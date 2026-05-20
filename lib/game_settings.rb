# frozen_string_literal: true

require 'colorize'
require_relative 'info_module'
require_relative 'player'

# This class was created for the presentation and configuration of various steps in the game.
class GameSettings
  attr_reader :avaliable_colors, :player_one, :player_two

  include Info

  def initialize
    @avaliable_colors = COLORS.dup
    @player_one = nil
    @player_two = nil
    @virtual_player = nil
  end

  def before_starting
    puts presentation
    players = number_of_players
    if players == '1'
      puts "\nYou have chosen to play against the computer...".green
      @player_one = create_player
      # implement the virtual player with name and the remaining colors
    elsif players == '2'
      puts "\nFirst Player ".green
      @player_one = create_player
      puts "\nSecond Player: ".green
      @player_two = create_player
    end
  end

  def create_player
    name = Info.enter_name
    show_colors(avaliable_colors)
    print "\n#{name}, "
    color = select_piece_color
    player = Player.new(name, color)
  end
end
