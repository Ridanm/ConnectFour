# frozen_string_literal: true

require 'colorize'
require '../lib/dependencies'

RSpec.describe Info do
  let(:settings) { GameSettings.new }
  let(:piece) { "\u2742" }
  let(:player_one) { Player.new('Jhonn', '1') }

  describe 'constants' do
    msj = ' Welcome to Connect Four game '
    it 'we call the header' do
      expect(Info::HEADING).to eq(msj)
    end

    it 'when we call the a space constant' do
      expect(Info::A_SPACE).to eq(' ')
    end

    it 'when we call the three spaces constant' do
      expect(Info::THREE_SPACES).to eq('   ')
    end
  end

  describe '#message' do
    select_column_messsge = 'Select a column between 1 and 7: '
    it 'when the row number is incorrect' do
      expect(Info.message('select column')).to eq(select_column_messsge)
    end

    it 'The column is full' do
      full_column_messsge = 'This column is complete, please select another !!!'.yellow
      expect(Info.message('full column')).to eq(full_column_messsge)
    end

    it 'select color' do
      select_color_message = 'Select the number corresponding to the color you want to play with: '
      expect(Info.message('select color')).to eq(select_color_message)
    end

    it "it's a draw" do
      draw_message = 'The board is full and there is no winner, they want to play again.'.green
      expect(Info.message("it's a draw")).to eq(draw_message)
    end

    it 'congratulations' do
      congratulations_message = "Congratulations \nYou're the winner!!!".green

      expect(Info.message('congratulations')).to eq(congratulations_message)
    end

    it 'game over' do
      game_over_message = "\nGAME OVER \nPress: 1 to play again \n       2 for new players \n       Or any key to exit".green
      expect(Info.message('game over')).to eq(game_over_message)
    end
  end

  describe '#presentation' do
    it 'when it displays the header' do
      msj = "\n  welcome to connect four".upcase.blue
      expect(settings.presentation).to eq(msj)
    end
  end

  describe '#show_colors' do
    it 'when it displays the available colors, the first color' do
      expect(subject::COLORS['1']).to eq("\u2742".red)
    end

    it 'when it displays the available colors, the last color' do
      expect(subject::COLORS['6']).to eq("\u2742".light_blue)
    end
  end

  describe '#select_piece_color' do 
    it 'when you select the blue piece' do
    allow(Info).to receive(:select_piece_color).and_return("3\n")
    expect(subject.select_piece_color).to eq("3\n")
  end

  it 'when select red piece' do
      allow(subject).to receive(:select_piece_color).and_return("1\n")
      expect(subject.select_piece_color).to eq("1\n")
    end

    it 'when you select a color that is not' do
      allow(settings).to receive(:gets).and_return("8\n", "2\n")
      expect(settings).to receive(:select_piece_color).and_call_original.exactly(2).times
      expect(settings.select_piece_color).to eq("2")
    end
  end

  describe '#enter_name' do
    let(:player_two) { Player.new('3') }

    it 'when the player enters their name' do
      allow(subject).to receive(:enter_name).and_return('Joe')
    end

    it 'when the player does not enter their name' do
      allow(subject).to receive(:enter_name).and_return(' ')
      expect(player_two.name).to eq('Player')
    end
  end
end
