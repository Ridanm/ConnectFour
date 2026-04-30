# frozen_string_literal: true

require 'colorize'
require '../lib/info_module'

RSpec.describe 'Info' do
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
    msj = 'Select a column between 1 and 7: '
    it 'when the row number is incorrect' do
      expect(Info.message('select column')).to eq(msj)
    end

    it 'The column is full' do
      msj = 'This column is complete, please select another !!!'.light_red
      expect(Info.message('full column')).to eq(msj)
    end

    it 'select color' do
      msj = 'Select the color of the piece you will play with: '
      expect(Info.message('select color')).to eq(msj)
    end
  end
end
