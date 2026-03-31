# frozen_string_literal: true       

require 'colorize'
require_relative 'dependencies'

# This class implement Connect Four game board
class Board
  attr_accessor :boxes, :column_numbers


  def initialize
    @boxes = Array.new(6) { Array.new(7, ' ') }
    @column_numbers = (1..7).to_a
  end

  def create_board
    separator = '-'.blue * 29
    result = headers_of_columns
    boxes.each do |box|
      result << "#{separator}\n#{'| '.blue}#{box.join(' | ')} #{'|'.blue}\n"
    end
    result << separator
    result
  end

  def headers_of_columns
    "\n  #{column_numbers.join('   ').yellow}\n"
  end

  def show_board
    puts create_board
  end

  def piece(color)
    { 'white' =>  "\u2742".white,
      'red' => "\u2742".red,
      'yellow' => "\u2742".yellow,
      'blue' => "\u2742".blue,
      'light red' => "\u2742".light_red,
      'cyan' => "\u2742".cyan,
      'light blue' => "\u2742".light_blue  
    }[color]
  end

  def drop_piece(column, piece)
    (boxes.length-1).downto(0) do |row|
      if boxes[row][column - 1] == ' '
        boxes[row][column - 1] = piece
        return true
      end
    end
    false
  end
end
