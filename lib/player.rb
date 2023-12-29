class Player 
	attr_reader :name 

	def initialize(name)
		@name = name.capitalize 
	end

	def piece 
		"\u2B55"
	end
end
