# frozen_string_literal: true

require_relative 'dependencies'

system('clear')
game_settings = GameSettings.new
game_settings.before_starting

game = Game.new(Board.new, game_settings.player_one, game_settings.player_two)
game.play