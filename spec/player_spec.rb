# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe Player do
  describe '#initialize' do
    it 'when an instance of the class is created' do
      expect(subject).to be_an_instance_of(Player)
    end

    it 'before entering the name' do
      expect(subject.name).to be('Player')
    end
  end

  describe '#enter_name' do
    it 'when the player enters their name' do
      expect(subject).to receive(:gets).and_return('Joe')
      subject.enter_name
      expect(subject.name).to eq('Joe')
    end

    it 'when the player does not enter their name' do
      expect(subject).to receive(:gets).and_return(' ')
      subject.enter_name
      expect(subject.name).to eq('Player')
    end
  end

  describe '#enter_piece_color' do
    it 'when you select the red piece' do
      expect(subject).to receive(:gets).and_return('red')
      expect(subject.enter_piece_color).to eq("\u2742".red)
    end

    it 'when select yellow piece' do
      expect(subject).to receive(:gets).and_return('yellow')
      expect(subject.enter_piece_color).to eq("\u2742".yellow)
    end

    it 'when you select a color that is not' do
      expect(subject).to receive(:gets).and_return('black', 'blue')
      expect(subject).to receive(:enter_piece_color).and_call_original.exactly(2).times
      expect(subject.enter_piece_color).to eq("\u2742".blue)
    end
  end

  describe '#valid_column' do
    it 'when the column number is correct' do
      expect(subject).to receive(:gets).and_return("4\n")
      expect(subject.valid_column).to eq(4)
    end

    it 'when the column number is not found' do
      expect(subject).to receive(:gets).and_return("8\n", "2\n")
      expect(subject).to receive(:valid_column).and_call_original.exactly(2).times
      expect(subject.valid_column).to eq(2)
    end
  end
end
