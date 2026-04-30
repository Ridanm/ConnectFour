# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Player' do
  let(:piece) { "\u2742" }
  let(:red_piece) { piece.red }
  let(:player_one) { Player.new('Joe', 'red') }
  let(:player_two) { Player.new('blue') }

  describe '#initialize' do
    it 'when an instance of the class is created' do
      expect(player_one).to be_an_instance_of(Player)
    end

    it 'before entering the name' do
      expect(player_two.name).to be('Player')
    end

    it 'when creating the player, the color of the piece' do
      player_three = Player.new('Ben', 'yellow')
      expect(player_three.piece_color).to eq("\u2742".yellow)
    end
  end

  describe '#enter_name' do
    it 'when the player enters their name' do
      expect(player_one).to receive(:enter_name).and_return('Joe')
      player_one.enter_name
      expect(player_one.name).to eq('Joe')
    end

    it 'when the player does not enter their name' do
      expect(player_two).to receive(:enter_name).and_return(' ')
      player_two.enter_name
      expect(player_two.name).to eq('Player')
    end
  end

  describe '#select_piece_color' do
    it 'when you select the blue piece' do
      expect(player_one).to receive(:gets).and_return("blue\n")
      expect(player_one.select_piece_color).to eq('blue')
    end

    it 'when select cyan piece' do
      expect(player_one).to receive(:gets).and_return("cyan\n")
      expect(player_one.select_piece_color).to eq('cyan')
    end

    it 'when you select a color that is not' do
      expect(player_two).to receive(:gets).and_return("black\n", "yellow\n")
      expect(player_two).to receive(:select_piece_color).and_call_original.exactly(2).times
      expect(player_two.select_piece_color).to eq('yellow')
    end
  end

  describe '#piece(color)' do
    let(:color_white) { player_one.piece('white') }
    let(:color_blue) { player_two.piece('blue') }
    let(:color_yellow) { player_one.piece('yellow') }

    it 'color is white' do
      expect(color_white).to eq(piece.white)
    end

    it 'color is blue' do
      expect(color_blue).to eq(piece.blue)
    end

    it 'color is yellow' do
      expect(color_yellow).to eq(piece.yellow)
    end
  end

  describe '#valid_column' do
    it 'when the column number is correct' do
      expect(player_one).to receive(:valid_column).and_return(4)
      expect(player_one.valid_column).to eq(4)
    end

    it 'when the column number is not found' do
      expect(player_two).to receive(:gets).and_return("8\n", "2\n")
      expect(player_two).to receive(:valid_column).and_call_original.exactly(2).times
      expect(player_two.valid_column).to eq(2)
    end
  end
end
