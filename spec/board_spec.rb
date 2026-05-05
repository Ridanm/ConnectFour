# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Board' do
  subject(:board) { Board.new }
  let(:piece) { "\u2742" }

  describe '#initialize' do
    it 'when initialize board' do
      expect(board.boxes).to be_an_instance_of(Array)
    end

    it 'when it displays a row' do
      row = board.boxes[0].length
      expect(row).to eq(7)
    end

    it 'total number of rows' do
      all_rows = board.boxes.length
      expect(all_rows).to eq(6)
    end

    it 'We checked the size of the board.' do
      board_size = board.boxes.flatten.size
      expect(board_size).to eq(42)
    end

    it 'column number' do
      expect(board.column_numbers).to contain_exactly(1, 2, 3, 4, 5, 6, 7)
    end
  end

  describe '#headers_of_columns' do
    it 'We add the headers numbers' do
      numbers = "\n  #{(1..7).to_a.join('   ').yellow}\n"
      expect(board.headers_of_columns).to eq(numbers)
    end
  end

  describe '#create_board' do
    let(:create) { board.create_board }

    it 'return a sgring containing the columns numbers' do
      expect(create).to include('1   2   3   4   5   6   7')
    end

    it 'return a string with the correct format' do
      expect(create).to start_with("\n  \e[0;33;49m1   2   3   4   5   6   7\e[0m")
    end

    it 'when displaying the dashboard for the first time' do
      first_time = board.boxes.flatten.all?(' ')
      expect(first_time).to be true
    end
  end

  describe '#drop_piece?' do
    it 'when player choose column 1' do
      board.drop_piece?(1, piece)
      expect(board.boxes[5][0]).to eq(piece)
    end

    it 'when the column is full' do
      board.boxes[5][0] = piece.red
      board.boxes[4][0] = piece
      4.times { board.drop_piece?(1, piece) }
      expect(board.drop_piece?(1, piece)).to be false
    end
  end
end
