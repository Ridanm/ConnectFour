# frozen_string_literal: true

# This module implements the information to be displayed in the classes and presentation of the game.
module Info
  HEADING = ' Welcome to Connect Four game '
  A_SPACE = ' '
  THREE_SPACES = '   '

  def self.message(parameter)
    { 'select column' => 'Select a column between 1 and 7.',
      'full column' => 'This column is complete.'.light_red
    }[parameter]
  end
end
