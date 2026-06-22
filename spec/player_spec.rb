# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Player' do
  let(:piece) { "\u2742" }
  let(:red_piece) { piece.red }
  let(:player_one) { Player.new('Joe', '1') }
  let(:player_two) { Player.new('2') }
  let(:board) { Board.new }

  describe '#initialize' do
    it 'when an instance of the class is created' do
      expect(player_one).to be_an_instance_of(Player)
    end

    it 'before entering the name' do
      expect(player_two.name).to be('Player')
    end

    it 'when creating the player, the color of the piece' do
      player_three = Player.new('Ben', '2')
      expect(player_three.piece_color).to eq("\u2742".yellow)
    end
  end

  describe '#piece(color)' do
    let(:player_four) { Player.new('jhonn', '1') }
    let(:player_five) { Player.new('player_5', '5') }

    it 'when player selects color 1' do
      expect(player_four.piece_color).to eq(red_piece)
      player_four.piece_color
    end

    it 'when player selects color 5' do
      expect(player_five.piece_color).to eq(piece.cyan)
    end
  end

  describe '#valid_column(board)' do
    it 'when the column number is correct' do
      allow(player_one).to receive(:valid_column).with(board).and_return(4)
      expect(player_one.valid_column(board)).to eq(4)
    end

    it 'when the column number is not found' do
      allow(player_two).to receive(:gets).and_return("8\n", "2\n")
      expect(player_two).to receive(:valid_column).with(board).and_call_original.exactly(2).times
      expect(player_two.valid_column(board)).to eq(2)
    end
  end
end
