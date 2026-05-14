# frozen_string_literal: true

require 'colorize'
require '../lib/game_settings'

# The GameSettings class is responsible for obtaining the data necessary for creating the players.
RSpec.describe GameSettings do
  let(:piece) { "\u2742" }

  describe '#initialize' do
    it 'when initialized with the info module colors' do
      expect(subject.avaliable_colors).not_to be_empty
    end

    it "Let's check the available colors" do
      expect(subject.avaliable_colors['1']).to eq(piece.red)
    end

    it 'when initializing the players' do
      expect(subject.player_one).to be_nil
      expect(subject.player_two).to be_nil
    end
  end

  describe '#create_player' do
    before do
      allow(Info).to receive(:enter_name).and_return('Alice')
      allow(subject).to receive(:show_colors)
      allow(subject).to receive(:gets).and_return("1\n")
      allow(Info).to receive(:select_piece_color).and_return("1\n")
    end

    it 'when you create an object of the player class' do
      player = subject.create_player
      expect(player).to be_a(Player)
      expect(player.name).to eq('Alice')
      expect(player.piece_color).to eq(piece.red)
    end
  end

  describe '#before_starting' do
    xit "when it's a single player" do
      allow(subject).to receive(:gets).and_return("1\n", 'joe', "3\n")
      #allow(subject).to receive(:create_player).and_return("joe\n")
      #allow(subject).to receive(:create_player).and_return("3\n")
      expect(subject.player_one).to eq(Player.new('joe', '3'))
      subject.create_player
    end
  end
end
