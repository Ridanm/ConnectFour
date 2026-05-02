# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Game' do
  let(:piece) { "\u2742" }
  let(:board) { Board.new }
  let(:player_one) { Player.new('Joe', 'red') }
  let(:player_two) { Player.new('blue') }
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
      expect(player_one).to receive(:gets).and_return('Joe')
      player_one.enter_name
      expect(player_one.name).to eq('Joe')
    end

    it 'when create player two' do
      expect(player_two).to respond_to(:select_piece_color)
    end

    it 'the number of moves at the start' do
      expect(game.number_of_moves).to eq(1)
    end
  end

  describe '#presentation' do
    it 'when it displays the welcome message' do
      welcome_message = 'WELCOME TO CONNECT FOUR'.blue
      expect(Info.message('welcome')).to eq(welcome_message)
    end
  end

  describe '#full_column?' do
    it 'when the column number is complete' do
      6.times { board.drop_piece?(1, piece) }
      expect(game.full_column?(1)).to be true
      expect(game.board.boxes[0][0]).to eq(piece)
    end

    it 'if the column still has space' do
      5.times { board.drop_piece?(1, piece) }
      expect(game.full_column?(1)).to be false
    end
  end

  describe '#swap_player' do
    it 'before changing players' do
      expect(game.number_of_moves).to be_odd
      expect(game.swap_player).to eq(game.player)
    end

    it 'when changing players' do
      expect(game.board).to receive(:show_board)
      allow(game.player).to receive(
        :valid_column
      ).and_return(2)
      game.play_turn
      expect(game.swap_player).to eq(player_two)
      expect(game.number_of_moves).to eq(2)
    end
  end

  describe '#play_turn' do
    before do
      expect(game.board).to receive(:show_board)
    end

    it 'if the column is full' do
      6.times { board.drop_piece?(1, piece) }
      allow(game.player).to receive(
        :valid_column
      ).and_return(1, 2)
      game.play_turn
      expect(game.board.boxes[5][1]).to eq(game.player.piece_color)
      expect(board.drop_piece?(2, game.player.piece_color)).to be(true)
    end

    it 'if the column is empty' do
      allow(game.player).to receive(:valid_column).and_return(1)
      game.play_turn
      expect(board.boxes[5][0]).to eq(game.player.piece_color)
    end
  end

  describe '#horizontal_victory?' do
    it 'when connect four in a row' do
      (1..4).each { |num| game.board.drop_piece?(num, game.player.piece_color) }
      expect(game.horizontal_victory?).to be true
    end

    it 'when there are no four in a row' do
      (1..3).each { |num| game.board.drop_piece?(num, game.player.piece_color) }
      expect(game.horizontal_victory?).to be false
    end
  end

  describe '#vertical_victofy?' do
    it 'when there are four in a vertical line' do
      4.times { game.board.drop_piece?(1, game.player.piece_color) }
      expect(game.vertical_victory?).to be true
    end

    it 'if there are not four in a vertical line' do
      3.times { game.board.drop_piece?(1, game.player.piece_color) }
      expect(game.vertical_victory?).to be false
    end
  end

  describe '#diagonal_victory' do
    it 'if there are four in a line diagonally downwards' do
      (0..3).each { |ind| board.boxes[ind][ind] = game.player.piece_color }
      expect(game.diagonal_victory?).to be true
    end

    it 'when you connect four diagonally upwards' do
      (0..3).each { |ind| board.boxes[5-ind][ind] = game.player.piece_color }
      expect(game.diagonal_victory?).to be true
    end
  end
end
