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
      expect(player_one.name).to eq('Joe')
    end

    it 'when create player two' do
      expect(player_two).to respond_to(:valid_column)
    end

    it 'the number of moves at the start' do
      expect(game.number_of_moves).to eq(1)
    end
  end

  describe '#presentation' do
    it 'when it displays the welcome message' do
      welcome_message = "\n  WELCOME TO CONNECT FOUR".blue
      expect(game.presentation).to eq(welcome_message)
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

  describe '#winner?' do
    it 'four in one column' do
      4.times { game.board.drop_piece?(1, game.player.piece_color) }
      expect(game.winner?).to be true
    end

    it 'four in a diagonal' do
      game.board.drop_piece?(4, piece)
      [[3, 4], [3, 3], [2, 2], [1, 1]].each do |count, col|
        count.times { game.board.drop_piece?(col, game.player.piece_color) }
      end
      expect(game.winner?).to be true
    end
  end

  describe '#draw' do
    it 'when is a draw' do
      allow(game).to receive(:number_of_moves).and_return(42)
      expect(game.draw).to be true
    end
  end

  describe 'play' do
    before do
      4.times { game.board.drop_piece?(2, game.player.piece_color) }
    end

    it 'when there is a winner' do
      msj = "  Congratulations  \n You got 4 in a row, you're the winner!!!"
      
      expect(game).to receive(:play).and_return(msj)
      game.play
    end

    it 'when is a draw' do
      msj = 'The board is full and there is no winner, they want to play again.'.yellow

      expect(game).to receive(:play).and_return(msj)
      game.play
    end
  end
end
