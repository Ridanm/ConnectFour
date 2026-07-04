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
      
      it 'the bot can return the column number 7' do
        expect(bot.avaliable_free_columns(board)).to eq(7)
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

  describe '#find_winning_move' do
    context 'if there are 3 pieces of the same color in column 3' do
      before do
        3.times { board.drop_piece?(3, bot.piece_color) }
      end
      
      it 'return the winning column' do
        result = bot.find_winning_move(board, bot.piece_color)
        expect(result).to eq(3)
      end
    end

    context 'when there is no winning column' do
      it 'return false' do
        result = bot.find_winning_move(board, bot.piece_color)
        expect(result).to be false
      end
    end
  end

  describe '#counting_tokens' do
    context 'if there are 2 pieces of the same color in column 6' do
      before do
        2.times { board.drop_piece?(6, bot.piece_color)}
        allow(bot).to receive(:rows).and_return(board.boxes)
      end
      
      it 'return true' do
        expect(bot.counting_tokens(2, bot.piece_color)).to be(true)
      end

      it 'return false' do
        expect(bot.counting_tokens(3, bot.piece_color)).to be(false)
      end
    end

    context 'if there are 3 pieces of the same color in square 7' do
      before do
        3.times { board.drop_piece?(7, bot.piece_color)}
        allow(bot).to receive(:rows).and_return(board.boxes)
      end

      it 'return true' do
        expect(bot.counting_tokens(3, bot.piece_color)).to be(true)
      end

      it 'return false' do
        expect(bot.counting_tokens(4, bot.piece_color)).to be(false)
      end
    end
  end
end
