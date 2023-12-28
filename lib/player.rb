require 'colorize'
class Player 
	attr_reader :name 

	def initialize(name)
		@name = name.capitalize 
	end

	def piece 
		"\u3007"
	end
end

player = Player.new('joe')
p player.name 

puts player.piece.blue