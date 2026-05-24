# frozen_string_literal: true

require_relative '../lib/dependencies'

# The GameSettings class is responsible for obtaining the data necessary for creating the players.
RSpec.describe GameSettings do
  let(:piece) { "\u2742" }
  let(:setup) { GameSettings.new }

  describe '#initialize' do
    it 'when initialized with the info module colors' do
      expect(subject.avaliable_colors).not_to be_empty
      expect(subject.avaliable_colors).to eq(Info::COLORS.dup)
    end

    it "Let's check the available colors" do
      expect(subject.avaliable_colors['1']).to eq(piece.red)
    end

    it 'when initializing the players' do
      expect(subject.player_one).to be_nil
      expect(subject.player_two).to be_nil
    end

    it 'when initializing the virtual_player' do
      expect(subject.virtual_player).to be_nil
    end
  end

  describe '#create_player' do
    before do
      allow(Info).to receive(:enter_name).and_return('Alice')
      expect(subject).to receive(:show_colors)
      allow(subject).to receive(:gets).and_return("1\n")
      allow(subject).to receive(:print)
      allow(subject).to receive(:puts)
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
    before do
      allow(subject).to receive(:presentation)
      allow(subject).to receive(:puts)
    end

    context 'if the number of players is 1' do
      it 'when a player is configured' do
        allow(subject).to receive(:number_of_players).and_return('1')
        fake_player = Player.new('Julia', '2')
        allow(subject).to receive(:create_player).and_return(fake_player)

        subject.before_starting

        expect(subject.player_one).to eq(fake_player)
        expect(subject.player_one.name).to eq('Julia')
        expect(subject.player_one.piece_color).to eq(piece.yellow)
      end

      it 'when virtual player is configured' do
        allow(subject).to receive(:number_of_players).and_return('1')
        allow(subject).to receive(:create_player)
        fake_bot = VirtualPlayer.new('1')
        allow(subject).to receive(:create_bot).and_return(fake_bot)

        subject.before_starting

        expect(subject.virtual_player).to be_a(VirtualPlayer)
        expect(subject.virtual_player.name).to eq('Computer')
        expect(subject.virtual_player.piece_color).to eq(piece.red)
     end
    end

    context 'if the number of players is 2' do
      it 'when two players are configured' do
        allow(subject).to receive(:number_of_players).and_return('2')
        player1 = Player.new('Anton', '1')
        player2 = Player.new('Brian', '5')
        allow(subject).to receive(:create_player).and_return(player1, player2)

        subject.before_starting

        expect(subject.player_one).to eq(player1)
        expect(subject.player_two).to eq(player2)
      end
    end
  end
end
