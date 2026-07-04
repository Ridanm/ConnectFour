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
    # verify that the column is not full
    avaliable_free_columns(board) || column_with_empty_cells(board)
  end

  def find_winning_move(board, bot_color)
    @board = board
    board.column_numbers.each do |column|
      column unless board.full_column?(column)
      board.drop_piece?(column, bot_color)
      return column if winner?(piece_color)
      board.remove_piece(column)
    end
    false
  end
  # Estos pasos van fuera porque son de la clase computer game y board respectivamente, a su vez el metodod find_winning_move() va eñdentro del metodo valid_column
  # 1- verificar si es movimiento ganador de no ser asi 
     # - podenos guardar los movimientos que tengan tres piezas consecutivas para usarls en el proximo movimiento.
  # 2- llamamod a board borrar ultima pieza colocada 
  # 3- repetimos el paso 1, 2, 3
  # Seriann7 movimientos 1 por columna si no hay winner? colocamos una ficha al azar
  
  def counting_tokens(amount, actual_color)
    all_lines.any? do |line|
      line.each_cons(amount).any? do |group|
        group.all?(actual_color)
      end
    end
  end
  
  def blocking_move(oponnent_color)
    # Prioridad 1: The opponent wins on their next turn? ¡blocking_move!
 # opponent_color = (color == 'red' ? 'yellow' : 'red') # Ajusta según tus colores
  #blocking_move = board.find_winning_move(opponent_color)
  #return blocking_move if blocking_move
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