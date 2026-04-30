# frozen_string_literal: true

require '../lib/dependencies'

# This class creates the player with their name and the color of the piece to play.
class Player < Board
  attr_reader :name, :piece_color,
    :piece

  include Info

  def initialize(name = 'Player', color)
    @piece = "\u2742"
    @name = name
    @piece_color = piece(color)
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

  def select_piece_color
    valid_colors = %w[ blue cyan red white yellow ]
    print Info.message('Select color')
#} #{valid_colors.join(', ')}: "
    color = gets.chomp.downcase
    return color if valid_colors.include?(color)

    select_piece_color
  end

  def piece(color)
    { 'white' => "\u2742".white,
      'red' => "\u2742".red,
      'yellow' => "\u2742".yellow,
      'blue' => "\u2742".blue,
      'light red' => "\u2742".light_red,
      'cyan' => "\u2742".cyan,
      'light blue' => "\u2742".light_blue }[color]
  end

  def valid_column
    print Info.message('select column')
    column = gets.chomp.to_i
    return column if column.between?(1, 7)

    valid_column
  end
end
