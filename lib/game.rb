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
    @number_of_moves = 1
    @player = swap_player
  end

  def full_column?(column)              if board.boxes[0][column - 1] != A_SPACE
      return true
    end
      false
  end

  def swap_player
    @player = (@number_of_moves.odd?) ? @player_one : @player_two
  end

  def play_turn
    board.show_board
    print @player.name 
    column = @player.valid_column
    until board.drop_piece?(column, @player.piece_color)
      puts Info.message('full column')
      column = @player.valid_column
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

  def draw
    number_of_moves >= 42 && winner? == false
  end

  def play
    until winner? || full_board?
      play_turn
      puts "#{@player.name} !!! #{Info.message('congratulations')}" if winner?
      puts Info.message("it's a draw") if draw
    end
  end

  def full_board?
    if number_of_moves == 42
      return true
    end
    false
  end

  def game_over?; end

  def play_again; end
end
