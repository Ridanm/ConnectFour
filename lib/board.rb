require 'colorize'

class Board 
	attr_accessor :board 

	def initialize 
		@board = Array.new(6) { Array.new(7, ' ') }
	end

	def each_box
		@board.each do |box|  
			separator = '-'.blue * 29
			puts "#{separator}\n#{'| '.blue}#{box.join(' | ')} #{'|'.blue}"
		end
	end

	def numbers_of_column 
		numbers = (1..7).to_a
		separator = '-'.blue * 29
		puts "#{separator}\n  #{numbers.join('   ').yellow}"
	end

	def show_board
		each_box
		numbers_of_column
	end
end 

b = Board.new 
b.board[5][0] = "\u25CE".red #"\u2B55".red
b.board[5][5] = "\u25CE".blue
b.show_board