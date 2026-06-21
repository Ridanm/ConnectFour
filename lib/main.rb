# frozen_string_literal: true

require_relative 'dependencies'

# Start the Game 
# 1- Welcome message
# 2- Select 
#    - Enter player name
#    - Select piece color
#      - Delete the selected color
#    - Implement bot
# 3- Two players
#    - First player name and select color of the piece
#    - Second player repeats previous steps
# 4- Main
#    - GameSettings instance
#    - GameSettings.before_starting complete the player setup steps
# 5- Game instance
#    - execution of the play method

game_settings = GameSettings.new
game_settings.before_starting

game = Game.new(Board.new, game_settings.player_one, game_settings.player_two)
game.play