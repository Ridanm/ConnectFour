# frozen_string_literal: true

require 'colorize'
require_relative 'dependencies'

# This class implement Connect Four game board
class Board
  attr_reader :boxes, :column_numbers

  include Info

  def initialize
    @boxes = Array.new(6) { Array.new(7, A_SPACE) }
    @column_numbers = (1..7).to_a
  end

  def create_board
    separator = '-'.green * 29
    result = headers_of_columns
    boxes.each do |box|
      result << "#{separator}\n| #{box.join(' | ')} |\n"
    end
    result << separator
    result
  end

  def headers_of_columns
    "\n  #{column_numbers.join(THREE_SPACES).yellow}\n"
  end

  def show_board
    puts create_board
  end

  def drop_piece?(column, piece)
    (@boxes.length - 1).downto(0) do |row|
      if @boxes[row][column - 1] == A_SPACE
        @boxes[row][column - 1] = piece
        return true
      end
    end
    false
  end

  def remove_piece(column, piece)
    # 1- First, verify that the bot has just placed a piece in that column.
    # 2- Check if there is a potential winner; if not, remove the piece to try another square
    # 3- Check again, and if there is still no winner, place the piece where there are more pieces of the same color.
  end
end
