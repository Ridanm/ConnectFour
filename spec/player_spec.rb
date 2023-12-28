require './lib/dependencies.rb' 

RSpec.describe Player do 
	let(:player) { Player.new('Jhon') }

	context '#initialize' do 
		it 'create a player instance' do 
			expect(player).to be_an_instance_of(Player)
 		end

		it 'create a name player instance' do 
			expect(player.name).to eq('Jhon')
		end
	end

		context '#name' do 
			player = Player.new('joe')

			it 'create a name player instace the first letter' do  
				expect(player.name).to eq('Joe')
			end
	end

	context '#piece' do 
		it 'to call the piece method' do 
			expect(player.piece).to eq('〇')
		end
	end
end