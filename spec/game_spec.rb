require './lib/dependencies.rb'

RSpec.describe 'Game' do 
	context 'when' do 
		it 'create class' do 
			expect(Game.new).to be_kind_of(Game)
		end
	end
end