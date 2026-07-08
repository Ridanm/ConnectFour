# frozen_string_literal: true

require_relative 'dependencies'

# This class implements the autonomous player in case of playing against the computer
class VirtualPlayer
  attr_reader :name, :piece_color, :color
  
  include Info
  include Victory

  def initialize(color)
    @name = 'Alpha_4'
    @piece_color = piece(color)
  end

  def valid_column(board, player_color)
    print 'Thinking...'
    sleep(1)
    # verify that the column is not full
    find_winning_move(board, piece_color) || blocking_move(board, player_color) || avaliable_free_columns(board) || column_with_empty_cells(board)
  end

  def find_winning_move(board, color)
    @board = board
    board.column_numbers.each do |column|
      next if board.full_column?(column)
      board.drop_piece?(column, color)
      if winner?(piece_color)
        board.remove_piece(column)
        return column
      end
      board.remove_piece(column)
    end
    nil
  end
  
  def counting_tokens(amount, actual_color)
    all_lines.any? do |line|
      line.each_cons(amount).any? do |group|
        group.all?(actual_color)
      end
    end
  end
  
  def blocking_move(board, opponent_color)
    @board = board
    board.column_numbers.each do |column|
      next if board.full_column?(column)
      board.drop_piece?(column, opponent_color)
      if winner?(opponent_color)
        board.remove_piece(column)
        return column
      end
      board.remove_piece(column)
    end
    nil
  end

  def avaliable_free_columns(board)
    columns = []
    free_columns = board.boxes.transpose
    free_columns.each_with_index do |row, index|
      columns << index + 1 if row.all? { |element| element == ' ' }
    end
      columns.sample
  end

  def column_with_empty_cells(board)
    columns = []
    squqres_with_space = board.boxes.transpose
    squqres_with_space.each_with_index do |row, index|
      columns << index + 1 if row.any? { |element| element == ' ' }
    end
      columns.sample
  end
end