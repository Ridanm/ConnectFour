# frozen_string_literal:true

require_relative 'dependencies'

# This class implements column validation, player creation, and how the pieces are arranged on the board.
class Game
  attr_reader :board

  include Info

  def initialize(board)
    @board = board
  end

  def valid_column!
    column = gets.chomp.to_i
    return column if column.between?(1, 7)

    puts Info.message('select column')
    valid_column!
  end

  def full_column?(column)
    if board.boxes[column - 1][0] != ' '
      puts Info.message('full column')
      return true
    end
    false
  end

  def player_move(piece)
    column = valid_column
    board.drop_piece(column, piece)
  end

  def switch_player; end

  def win?; end

  def game_over?; end

  def play_again; end

  def play; end
end
