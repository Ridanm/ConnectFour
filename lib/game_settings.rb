# frozen_string_literal: true

require_relative './dependencies'

# This class was created for the presentation and configuration of various steps in the game.
class GameSettings
  attr_reader :avaliable_colors, :player_one, :player_two

  include Info

  def initialize
    @avaliable_colors = COLORS.dup
    @player_one = nil
    @player_two = nil
  end

  def before_starting
    puts presentation
    players = number_of_players
    if players == '1'
      puts "\nYou have chosen to play against the computer...".green
      @player_one = create_player
      puts "\nVirtual Player".green
      system('clear')
      @player_two = create_bot
      system('clear')
    elsif players == '2'
      puts "\nFirst Player ".green
      @player_one = create_player
      system('clear')
      puts "\nSecond Player: ".green
      @player_two = create_player
      system('clear')
    end
  end

  def create_player
    name = Info.enter_name
    show_colors(avaliable_colors)
    print "\n#{name}, "
    color = select_piece_color
    Player.new(name, color)
  end

  def create_bot
    show_colors(avaliable_colors)
    bot_color = avaliable_colors.keys.sample
    puts "Selected piece: #{avaliable_colors[bot_color]}"
    sleep(1)
    VirtualPlayer.new(bot_color)
  end
end