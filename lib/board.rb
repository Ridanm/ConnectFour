# El tablero puede ser de 5 x 4 hasta 8 x 8 
# el estandar es de 6 filas 7 columnas 
# https://en.wikipedia.org/wiki/List_of_Unicode_characters#Miscellaneous_Symbols
require 'colorize'

class Board 
	attr_reader :board 

	def initialize 
		@board = (0..42).to_a
	end

	def show_board
		col_separator, row_separator = ' | '.blue, '---+----+----+----+----+----+---'.blue
		box_space = ' ' * 2 
		label_for_position = ->(position) { @board[position] ? @board[position] = box_space : position }
		row_display = ->(row) { row.map(&label_for_position).join(col_separator) }

		row_positions = [
			[36, 37, 38, 39, 40, 41, 42],
			[29, 30, 31, 32, 33, 34, 35], 
			[22, 23, 24, 25, 26, 27, 28], 
			[15, 16, 17, 18, 19, 20, 21],
			[8, 9, 10, 11, 12, 13, 14], 
			[1, 2, 3, 4, 5, 6, 7]
		]
		rows_for_display = row_positions.map(&row_display)
		space = ' ' * 4
		col_numbers = (1..7).to_a.join(space)
    puts "\n#{ rows_for_display.join("\n" + row_separator + "\n") }\n#{col_numbers}\n\n"
	end
end 

# b = Board.new 
# b.show_board