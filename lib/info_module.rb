# frozen_string_literal: true

# This module implements the information to be displayed in the classes and presentation of the game.
module Info
  HEADING = ' Welcome to Connect Four game '
  A_SPACE = ' '
  THREE_SPACES = '   '

  def self.message(parameter)
    { 'welcome' => 'welcome to connect four'.upcase.blue,
      'select column' => 'Select a column between 1 and 7: ',
      'full column' => 'This column is complete, please select another !!!'.yellow,
      'select color' => 'Select the color of the piece you will play with: ',
      "it's a draw" => 'The board is full and there is no winner, they want to play again.'
    }[parameter]
  end
end
