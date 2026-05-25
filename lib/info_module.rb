# frozen_string_literal: true

# This module implements the information to be displayed in the classes and presentation of the game.
module Info
  HEADING = ' Welcome to Connect Four game '
  A_SPACE = ' '
  THREE_SPACES = '   '

  COLORS = {
    '1' => "\u2742".red,
    '2' => "\u2742".yellow,
    '3' => "\u2742".blue,
    '4' => "\u2742".green,
    '5' => "\u2742".cyan,
    '6' => "\u2742".light_blue 
  }.freeze

  def self.message(parameter)
    { 'welcome' => "\n  welcome to connect four".upcase.blue,
      'select column' => 'Select a column between 1 and 7: ',
      'full column' => 'This column is complete, please select another !!!'.yellow,
      'select color' => 'Select the number corresponding to the color you want to play with: ',
      "it's a draw" => 'The board is full and there is no winner, they want to play again.'.yellow,
      'congratulations' => "Congratulations \nYou're the winner!!!".green,
      'number of players' => "\nYou can choose between:\n - 1 player against the computer,\n - 2 players.... \n\nSelect the number of players: " }[parameter]
  end

  def presentation
    Info.message('welcome')
  end

  def show_colors(colors)
    puts "\nAvailable Colors: \n\n".blue
    colors.each do |key, value|
      puts "#{key} => #{value}\n\n"
    end
  end

  def select_piece_color 
    print "#{Info.message('select color')}"
    color = gets.chomp.downcase
    puts
    if @avaliable_colors.include?(color)
      puts "Selected piece: #{@avaliable_colors[color]}"
      @avaliable_colors.delete(color)
      return color
    else
      select_piece_color
    end
  end

  def self.enter_name
    print "\nPlease enter your name: "
    write_name = gets.chomp.capitalize.strip.squeeze(' ')
    if ['', ' '].include?(write_name)
      @name
    else
      @name = write_name
    end
  end

  def number_of_players
    print Info.message('number of players')
    number = gets.chomp
    return number if number.to_i.between?(1, 2)

    number_of_players
  end
end
