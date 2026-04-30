# frozen_string_literal:true

require_relative 'dependencies'

# This class implements column validation, player creation, and how the pieces are arranged on the board.
class Game
  attr_accessor :board, :player, :player_one, :player_two, :number_of_moves

  include Info

  def initialize(board, player_one, player_two)
    @board = board
    @player_one = player_one
    @player_two = player_two
    @number_of_moves = 1
    @player = swap_player
  end

  def presentation
    puts Info.message('welcome')      end

  def full_column?(column)              if board.boxes[column - 1][0] != ' ' 
      puts Info.message('full column
')
      return true
    end
    false
  end

  def swap_player
    player = number_of_moves
    player.odd? ? player_one : player_two
  end

  def play_turn
    board.show_board
    column = player.valid_column
    until board.drop_piece?(column, player.piece_color)
      full_column?(column)
      column = player.valid_column
    end

    increase_box_number
  end

  def increase_box_number
    @number_of_moves += 1
  end

  def win?; end

  def game_over?; end

  def play_again; end
end
