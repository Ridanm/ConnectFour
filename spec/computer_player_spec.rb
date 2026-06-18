# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/computer_player'

RSpec.describe VirtualPlayer do
  let(:computer) { Player.new('2')}
  let(:piece) { "\u2742" }

  describe '#initialize' do
    comp = VirtualPlayer.new('1')

    it 'the name of the virtual player' do
      expect(comp.name).to eq('Alpha_4')
    end

    it 'the color of the virtual player' do
      expect(comp.piece_color).to eq(piece.red)
    end
  end

  describe '#valid_column' do
    it 'when column 2 is selected' do
      expect(computer.valid_column).to eq(2)
    end
  end
end
