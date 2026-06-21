# frozen_string_literal: true

require 'pry-byebug'
require_relative 'dependencies'
require_relative 'board'
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
    avaliable_free_columns(board) || column_with_empty_cells(board)
  
  # Prioridad 1: ¿Puedo ganar en este turno?
 # winning_move = board.find_winning_move(color)
  #return winning_move if winning_move

  # Prioridad 2: ¿El rival va a ganar en su próximo turno? ¡Bloquear!
 # opponent_color = (color == 'red' ? 'yellow' : 'red') # Ajusta según tus colores
  #blocking_move = board.find_winning_move(opponent_color)
  #return blocking_move if blocking_move

  # Prioridad 3: Si no hay peligro ni victoria inminente, elegir al azar o el centro
  #board.free_columns.sample
   # sleep(1)
  end

  def find_winning_move(alpha_color)
    # verificar que el color se pueda colocar en linea, columna, diagonal
    # de lo contrario elegir otra columna donde tenga mas fichas si las hay
  end

  def opponent_winning_move(oponnent_color)
    
  end

  def avaliable_free_columns(board)
    columns = []
    free_columns = board.boxes.transpose
    free_columns.each_with_index do |row, index|
      columns << index + 1 if row.all? { |element| element == ' ' }
    end
    #.implement step when columns are empty
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