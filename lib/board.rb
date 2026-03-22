# frozen_string_literal: true       

require_relative 'dependencies'
require 'colorize'

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
      'light_red' => "\u2742".light_red
    }[color]
  end
end
