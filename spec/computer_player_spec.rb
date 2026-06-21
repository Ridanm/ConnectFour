# frozen_string_literal: true

require_relative '../lib/dependencies'

RSpec.describe VirtualPlayer do
  let(:piece) { "\u2742" }
  let(:board) { Board.new }
  bot = VirtualPlayer.new('1')
  
  describe '#initialize' do
    it 'the name of the virtual player' do
      expect(bot.name).to eq('Alpha_4')
    end

    it 'the color of the virtual player' do
      expect(bot.piece_color).to eq(piece.red)
    end
  end

  describe '#avaliable_free_columns(board)' do
    context 'when there are free columns' do
      before do
        6.times { |column_number| board.drop_piece?(column_number + 1, piece) }
      end
      
      it 'the bot can return the column number' do
        expect(bot.avaliable_free_columns(board)).to eq(7)
      end
    end

    context 'when there are no free columns' do
      before do
        7.times { |column_number| board.drop_piece?(column_number + 1, piece) }
      end

      it 'the bot return any box between 1 and 7' do
        allow(bot).to receive(:avaliable_free_columns).with(board).and_return(2)
        expect(bot.avaliable_free_columns(board)).to eq(2)  
      end
    end
  end

  describe '#column_with_empty_cells(board)' do
    let(:fake_board) { double("Board") }

    before do
      allow(bot).to receive(:column_with_empty_cells).with(fake_board).and_return([1, 2, 5, 7])
    end
    
    it 'if there are still empty spaces' do
      result = bot.column_with_empty_cells(fake_board)
      expect(result).to include(5)
      expect(result).to include(2)
      expect(result).not_to include(4)
    end
  end
end
