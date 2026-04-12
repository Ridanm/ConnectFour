# frozen_string_literal: true

require '../lib/dependencies'

# This class creates the player with their name and the color of the piece to play.
class Player < Board
  attr_reader :name, :piece_color

  def initialize
    super
    @name = 'Player'
  end

  def enter_name
    print 'Enter your name: '
    write_name = gets.chomp.capitalize.strip.squeeze(' ')
    if ['', ' '].include?(write_name)
      @name
    else
      @name = write_name
    end
  end

  def enter_piece_color
    valid_colors = %w[red blue yellow]
    print "Select circle color (#{valid_colors.join(', ')}): "
    color = gets.chomp.downcase
    return piece(color) if valid_colors.include?(color)

    enter_piece_color
  end

  def valid_column
    column = gets.chomp.to_i
    return column if column.between?(1, 7)

    puts Info.message('select column')
    valid_column
  end
end
