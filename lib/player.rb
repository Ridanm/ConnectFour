# frozen_string_literal: true

require '../lib/dependencies'
# This class creates the player with their name and the color of the piece to play.
class Player < Board
  attr_reader :name, :piece_color

  def initialize
    @name = 'Player'
  end

  def enter_name
    print 'Enter your name: '
    name = gets.chomp.capitalize.strip.squeeze(' ')
    if name == '' || name == ' '
      @name
    else
      @name = name
    end
    @name
  end

  def enter_piece_color
    valid_colors = %w(red blue yellow)
    print "Select circle color (#{valid_colors.join(', ')}): "
    color = gets.chomp.downcase
    return piece(color) if valid_colors.include?(color)
    enter_piece_color
  end
end
