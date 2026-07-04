# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Victory' do
  let(:board) { Board.new }
  let(:piece) { "\u2742" }
  let(:player_one) { Player.new(name: 'Joe', color: 'yellow') }
  let(:player_two) { Player.new(name: 'Ron', color: 'cyan') }
  let(:game) { Game.new(board, player_one, player_two) }

  describe '#all_lines' do
    it 'contains the correct number of rows + columns + diagonals' do
      expect(game.all_lines.size).to be > 13
    end

    it 'extract a specific row correctly' do
      game.board.drop_piece?(1, game.player.piece_color)
      expect(game.rows[5]).to include(game.player.piece_color)
    end
  end

  describe '#winner' do
    context 'when there is a vertical winner' do
      it 'return true' do
        4.times { game.board.drop_piece?(3, game.player.piece_color) }
        expect(game.winner?(game.player.piece_color)).to be true
      end
    end

    context 'when is a horizontal winmer' do
      it 'return true' do
        (1..4).each { |num| game.board.drop_piece?(num, piece) }
      end
    end

    context 'when the diagonal is descending' do
      it 'retuurn true' do
        [[4, 2], [3, 3], [2, 4], [1, 5]].each do |count, col|
          count.times { game.board.drop_piece?(col, game.player.piece_color) }
        end
        expect(game.winner?(game.player.piece_color)).to be true
      end
    end

    context 'when no one has 4 in a row' do
      it 'return false' do
        expect(game.winner?(game.player.piece_color)).to be false
      end
    end
  end
end
