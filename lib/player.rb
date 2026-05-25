# frozen_string_literal: true

require_relative 'board'
require_relative 'info_module'

# This class creates the player with their name and the color of the piece to play.
class Player < Board
  attr_reader :name, :piece_color, :color

  include Info

  def initialize(name = 'Player', color)
    @name = name
    @piece_color = piece(color)
  end

  def piece(color)
    { '1' => "\u2742".red,
      '2' => "\u2742".yellow,
      '3' => "\u2742".blue,
      '4' => "\u2742".green,
      '5' => "\u2742".cyan,
      '6' => "\u2742".light_blue }[color]
  end

  def valid_column
    print "\n#{Info.message('select column')}"
    column = gets.chomp.to_i
    return column if column.between?(1, 7)

    valid_column
  end
end
