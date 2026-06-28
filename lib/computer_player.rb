# frozen_string_literal: true

require_relative 'dependencies'

# This class implements the autonomous player in case of playing against the computer
class VirtualPlayer
  attr_reader :name, :piece_color, :color
  
  include Info
  include Victory

  def initialize(color)
    @name = 'Alpha_4'
    @piece_color = piece(color)
  end

  def valid_column(board)
    print 'Is thimking...'
    sleep(1)
    p avaliable_free_columns(board) || column_with_empty_cells(board)
    # Prioridad 1: The opponent wins on their next turn? ¡blocking_move!
 # opponent_color = (color == 'red' ? 'yellow' : 'red') # Ajusta según tus colores
  #blocking_move = board.find_winning_move(opponent_color)
  #return blocking_move if blocking_move
    
  # Prioridad 2: I can ein in this turn? 
 # winning_move = board.find_winning_move(color)
  #return winning_move if winning_move

  # Prioridad 3: If there is no inmminent victory, select any.
  #board.free_columns.sample
   # sleep(1)
  end

  def find_winning_move(bot_color)
    
  end

  def counting_tokens(amount, actual_color)
    all_lines.any? do |line|
      line.each_cons(amount).any? do |group|
        group.all?(actual_color)
      end
    end
  end
  
  def opponent_winning_move(oponnent_color)
    
  end

  def avaliable_free_columns(board)
    columns = []
    free_columns = board.boxes.transpose
    free_columns.each_with_index do |row, index|
      columns << index + 1 if row.all? { |element| element == ' ' }
    end
      columns.sample
  end

  def column_with_empty_cells(board)
    columns = []
    squqres_with_space = board.boxes.transpose
    squqres_with_space.each_with_index do |row, index|
      columns << index + 1 if row.any? { |element| element == ' ' }
    end
      columns.sample
  end
end

# Notes to reviews
# Method remove_piece created in board class.
# 1- First, verify that the bot has just placed a piece in that column.
    # 2- Check if there is a potential winner; if not, remove the piece to try another square
    # 3- Check again, and if there is still no winner, place the piece where there are more pieces of the same color.