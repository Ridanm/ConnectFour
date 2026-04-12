# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Game' do
  let(:piece) { "\u2742" }
  let(:board) { Board.new }
  let(:player) { Player.new }
  let(:player_one) { instance_double(Player) }
  let(:player_two) { instance_double(Player) }
  subject(:game) { Game.new(board, player_one, player_two) }

  describe '#initialize' do
    it 'when create board' do
      expect(game.board).to respond_to(:boxes)
    end

    it 'the number of boxes' do
      boxes = game.board.boxes.flatten.count
      expect(boxes).to eq(42)
    end

    it 'when create player one' do
      expect(player).to receive(:gets).and_return('Joe')
      player.enter_name
      expect(player.name).to eq('Joe')
    end

    it 'when create player two' do
      expect(player).to respond_to(:enter_piece_color)
    end

    it 'the number of moves at the start' do
      expect(game.number_of_moves).to eq(1)
    end
  end

  describe '#presentation' do
    it 'when it displays the welcome message' do
      welcome_message = 'WELCOME TO CONNECT FOUR'.on_blue
      expect(Info.message('welcome')).to eq(welcome_message)
    end
  end

  describe '#column_full?' do
    it 'when the column number is complete' do
      6.times { board.drop_piece?(1, piece) }
      expect(game.full_column?(1)).to be true
    end

    it 'if the column still has space' do
      expect(game.full_column?(1)).to be false
    end
  end

  describe '#swap_player' do
    it 'before changing players' do
      expect(game.swap_player).to eq(player_one)
    end

    xit 'when changing players' do
      game.swap_player
      expect(game.swap_player).to eq(player_two)
    end
  end

  describe '#player_move' do
    it 'when a player drops a piece' do
      expect(player).to receive(:gets).and_return("2\n")
      column = player.valid_column
      expect(game.player_move(column, piece)).to be true
    end
  end

  describe '#play_turn' do
    xit 'if the column is full' do

    end

    xit 'if the column is empty' do

    end
  end
end
