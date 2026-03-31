# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Game' do
  let(:piece) { "\u2742" }
  let(:board) { Board.new }
  let(:game) { Game.new(board) }

  describe '#initialize' do
    it 'when create class' do
      expect(game.board).to respond_to(:boxes)
    end
  end

  describe '#valid_column' do
    it 'when the column number is correct' do
      expect(game).to receive(:gets).and_return("4\n")
      expect(game.valid_column!).to eq(4)
    end

    it 'when the column number is not found' do
      expect(game).to receive(:gets).and_return("8\n", "2\n")
      expect(game).to receive(:valid_column!).and_call_original.exactly(2).times
      expect(game.valid_column!).to eq(2)
    end
  end

  describe '#column_full?' do
    it 'when the column number is complete' do
      6.times { board.drop_piece(1, piece) }
      expect(game.full_column?(1)).to be true
    end

    it 'if the column still has space' do
      expect(game.full_column?(1)).to be false
    end
  end
end
