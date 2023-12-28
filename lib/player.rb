class Player 
	attr_reader :name 

	def initialize(name)
		@name = name.capitalize 
	end

	def piece 
		"\u3007"
	end
end
