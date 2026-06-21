# frozen_string_literal:true

require_relative 'dependencies'

# This class implements column validation, player creation, and how the pieces are arranged on the board.
class Game
  attr_accessor :board, :player, :player_one, :player_two, :number_of_moves

  include Info
  include Victory

  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
    @number_of_moves = 0
    @player = swap_player
  end

  def full_column?(column)              if board.boxes[0][column - 1] != A_SPACE
      return true
    end
      false
  end

  def swap_player
    @player = (@number_of_moves.even?) ? @player_one : @player_two
  end

  def current_player_info
    print "\n#{@player.name}, piece color => #{@player.piece_color}: "
  end

  def play_turn
    board.show_board
    current_player_info
    column = @player.valid_column(@board)
    until board.drop_piece?(column, @player.piece_color)
      puts Info.message('full column')
      column = @player.valid_column(@board)
    end
    @number_of_moves += 1
    swap_player
  end

  def winner?
    all_lines.any? do |line|
      line.each_cons(4).any? do |cons|
        cons.all?(@player.piece_color)
      end
    end
  end

  def draw?
    if full_board? == true && winner? == false
      return true
    end
    false
  end

  def play
    until winner? || full_board?
      play_turn
    end
      show_text_at_the_end
      select_option_when_finished
  end

  def full_board?
    if number_of_moves == 42
      return true
    end
    false
  end

  def play_again
    puts "\nNew Board".green
    @board = Board.new
    @number_of_moves = 0
    @player = swap_player
    play
  end

  def enter_text
    gets.chomp.downcase.strip.squeeze
  end

  def select_option_when_finished
    selected = enter_text
    if selected == '1'
      play_again
    elsif selected == '2'
      new_players
    else
      puts "\nThanks for playing".green
    end
  end

  def show_text_at_the_end
    puts current_player_info, Info.message('congratulations') if winner?
    puts Info.message("it's a draw") if draw?
    puts Info.message('game over') if winner? or draw?
  end

  def new_players
    puts "\nNew Players".green
    game_settings = GameSettings.new
    game_settings.before_starting

    @board = Board.new
    @player_one = game_settings.player_one
    @player_two = game_settings.player_two
    @number_of_moves = 0  
    @player = swap_player
    play
  end

  def save_game
    # 3 save the current game 
  end
end
