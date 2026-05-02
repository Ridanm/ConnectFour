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

  def full_column?(column)              if board.boxes[0][column - 1] != A_SPACE
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
      puts Info.message('full column')
      column = player.valid_column

    end

    @number_of_moves += 1
  end

  def horizontal_victory?
    @board.boxes.each do |row|
      row.each_cons(4) do |line|
        return true if line.all? { |box| box == player.piece_color }
      end
    end

    false
  end

  def vertical_victory?
    transpose_boxes = @board.boxes.transpose
    transpose_boxes.each do |row|
      row.each_cons(4) do |column|
        return true if column.all? { |box| box == player.piece_color }
      end
    end

    false
  end

  def descending_diagonal?
    (0..2).each do |row|
      (0..3).each do |col|
        return true if (0..3).all? { |ind| board.boxes[row + ind][col + ind] == player.piece_color}
      end
    end

    false
  end

  def ascending_diadonal?
    (3..5).each do |row|
      (0..3).each do |col|
        return true if (0..3).all? { |ind| board.boxes[row - ind][col + ind] == player.piece_color }
      end
    end

    false
  end

  def diagonal_victory?
    descending_diagonal? || ascending_diadonal?
  end

  def winner?
    horizontal_victofy? || vertical_victory? || diagonal_victory?
  end

  def draw
    puts Info.message("It's a draw") if number_of_moves > 42 and winner? == false
  end

  def game_over?; end

  def play_again; end
end
