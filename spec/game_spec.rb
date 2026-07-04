# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe 'Game' do
  let(:piece) { "\u2742" }
  let(:board) { Board.new }
  let(:player_one) { Player.new('Joe', 'red') }
  let(:player_two) { Player.new('blue') }
  subject(:game) { Game.new(board, player_one, player_two) }
  let(:game_setup) { GameSettings.new }

  describe '#initialize' do
    it 'when create board' do
      expect(game.board).to respond_to(:boxes)
    end

    it 'the number of boxes' do
      boxes = game.board.boxes.flatten.count
      expect(boxes).to eq(42)
    end

    it 'when create player one' do
      expect(player_one.name).to eq('Joe')
    end

    it 'when create player two' do
      expect(player_two).to respond_to(:valid_column)
    end

    it 'the number of moves at the start' do
      expect(game.number_of_moves).to eq(0)
    end
  end

  describe '#presentation' do
    it 'when it displays the welcome message' do
      welcome_message = "\n  WELCOME TO CONNECT FOUR".blue
      expect(game.presentation).to eq(welcome_message)
    end
  end

  describe '#full_column?' do
    it 'when the column number is complete' do
      6.times { board.drop_piece?(1, piece) }
      expect(game.board.full_column?(1)).to be true
      expect(game.board.boxes[0][0]).to eq(piece)
    end

    it 'if the column still has space' do
      5.times { board.drop_piece?(1, piece) }
      expect(game.board.full_column?(1)).to be false
    end
  end

  describe '#swap_player' do
    it 'before changing players' do
      expect(game.number_of_moves).to be_even
      expect(game.swap_player).to eq(game.player)
    end

    it 'when changing players' do
      expect(game.board).to receive(:show_board)
      allow(game.player).to receive(
        :valid_column
      ).and_return(2)
      game.play_turn
      expect(game.swap_player).to eq(player_two)
      expect(game.number_of_moves).to eq(1)
    end
  end

  describe '#current_player_info' do
    before do
      allow(game_setup).to receive(:presentation)
      allow(game_setup).to receive(:puts)
      allow(game_setup).to receive(:number_of_players).and_return('1')
      allow(game_setup).to receive(:show_colors)
      allow(game_setup).to receive(:create_bot)
    end

    it 'if the player in play is player one' do
      fake_player = Player.new('Leti', '2')
      allow(game_setup).to receive(:create_player).and_return(fake_player)
      game_setup.before_starting
      expect(game_setup.player_one).to be_a(Player)
    end
  end

  describe '#play_turn' do
    before do
      expect(game.board).to receive(:show_board)
    end

    it 'if the column is full' do
      6.times { board.drop_piece?(1, piece) }
      allow(game.player).to receive(
        :valid_column
      ).and_return(1, 2)
      game.play_turn
      expect(game.board.boxes[5][1]).to eq(game.player.piece_color)
      expect(board.drop_piece?(2, game.player.piece_color)).to be(true)
    end

    it 'if the column is empty' do
      allow(game.player).to receive(:valid_column).and_return(1)
      game.play_turn
      expect(board.boxes[5][0]).to eq(game.player.piece_color)
    end
  end

  describe '#winner?' do
    it 'four in one column' do
      4.times { game.board.drop_piece?(1, game.player.piece_color) }
      expect(game.winner?(game.player.piece_color)).to be true
    end

    it 'four in a diagonal' do
      game.board.drop_piece?(4, piece)
      [[3, 4], [3, 3], [2, 2], [1, 1]].each do |count, col|
        count.times { game.board.drop_piece?(col, game.player.piece_color) }
      end
      expect(game.winner?(game.player.piece_color)).to be true
    end
  end

  describe '#draw?' do
    before do
      allow(game).to receive(:full_board?).and_return(true)
      allow(game).to receive(:winner?).with(game.player.piece_color).and_return(false)
    end

    it 'when is a draw?' do
      expect(game.draw?).to be true
    end
  end

  describe 'play' do
    before do
      4.times { game.board.drop_piece?(2, game.player.piece_color) }
    end

    it 'when there is a winner' do
      msj = "  Congratulations  \n You got 4 in a row, you're the winner!!!"

      expect(game).to receive(:play).and_return(msj)

      game.play
    end

    it 'when is a draw' do
      msj = 'The board is full and there is no winner, they want to play again.'.yellow

      expect(game).to receive(:play).and_return(msj)
      game.play
    end
  end

  describe '#play_again' do
    let(:one) { Player.new('David', '2') }
    let(:two) { Player.new('Ale', '1') }
    let(:new_game) { Game.new(board, one, two) }
    before do
      allow(new_game).to receive(:play)
    end

    it 'when the game ends and the selection is 1 play again' do
      new_game.instance_variable_set(:@number_of_moves, 10)
      old_board = new_game.instance_variable_get(:@board)

      new_game.play_again
      expect(new_game.number_of_moves).to eq(0)
      expect(new_game.instance_variable_get(:@board)).not_to eq(old_board)
      expect(new_game.board).to be_a(Board)
    end

    it 'if the game is repeated, the swap method' do
      expect(new_game).to receive(:swap_player).ordered
      expect(new_game).to receive(:play).ordered
      new_game.play_again
    end
  end

  describe '#enter_text' do
    it 'when entering the text' do
      allow(game).to receive(:gets).and_return('1 ')
      expect(game.enter_text).to eq('1')
    end

    it 'when entering text with spaces' do
      allow(game).to receive(:gets).and_return('  A exIT  ')
      expect(game.enter_text).to eq('a exit')
    end
  end

  describe '#select_option_when_finished' do
    it 'when the game ends and the choice is to leave' do
      msj = "\e[0;32;49m\nThanks for playing\e[0m\n"
      allow(game).to receive(:enter_text).and_return('j')
      expect { game.select_option_when_finished }.to output(msj).to_stdout
    end
  end

  describe '#show_text_at_the_end' do
    before do
      allow(Info).to receive(:message).with('congratulations').and_return('Congratulations!!!')
      allow(Info).to receive(:message).with('game over').and_return('Game Over')
      allow(game).to receive(:current_player_info).and_return('Player 1')
    end

    context 'when there is a winner' do
      before do
        allow(game).to receive(:winner?).with(game.player.piece_color).and_return(true)
        allow(game).to receive(:draw?).and_return(false)
      end

      it 'Print player information, congratulations, and game over' do
        congratulation_message = "Player 1\nCongratulations!!!\nGame Over\n"
        expect { game.show_text_at_the_end }.to output(congratulation_message).to_stdout
      end
    end

    context 'when the board is full' do
      before do
        allow(game).to receive(:winner?).and_return(false)
        allow(game).to receive(:draw?).and_return(true)
        allow(Info).to receive(:message).with("it's a draw").and_return("It's a draw")
      end

      it "the message it's a draw" do
        draw_message = "It's a draw\nGame Over\n"
        expect { game.show_text_at_the_end }.to output(draw_message).to_stdout
      end
    end

    context 'during the course of the game' do
      before do
        allow(game).to receive(:winner?).with(player_one.piece_color).and_return(false)
        allow(game).to receive(:draw?).and_return(false)
      end

      it "It doesn't print anything." do
        expect { game.show_text_at_the_end }.to output('').to_stdout
      end
    end
  end

  describe '#new_players' do
      let(:player_1) { Player.new('Lola', '4') }
      let(:player_2) { Player.new('ken', '1') }
      let(:game) { Game.new(board, player_1, player_2)}

    context 'current player 1' do
      it 'We verified the player exists' do
        expect(game.player_one).to be_a_kind_of(Player)
      end

      it 'current player 1 name' do
        expect(game.player_one.name).to eq('Lola')
      end
      
      it 'current player 1 piece color' do              expect(game.player.piece_color).to eq(piece.green)
      end
    end

    context 'when the game ends' do
      let(:mock_board) { instance_double(Board) }
      let(:mock_settings) { instance_double(GameSettings) }
      let(:new_player_1) { Player.new('New_player_1', '2') }
      let(:new_player_2) { Player.new('new_player_2', '6') }
      
      before do
        allow(game).to receive(:draw?).and_return(true)
        allow(game).to receive(:show_text_at_the_end).and_return('2')
        allow(game).to receive(:puts)
        allow(GameSettings).to receive(:new).and_return(mock_settings)
        allow(mock_settings).to receive(:before_starting)
        allow(mock_settings).to receive(:player_one).and_return(new_player_1)
        allow(mock_settings).to receive(:player_two).and_return(new_player_2)
        allow(Board).to receive(:new).and_return(mock_board)
        allow(game).to receive(:swap_player).and_return(new_player_1)
        allow(game).to receive(:play)
      end
      
      it 'and the selection is 2 new players' do
        expect(GameSettings).to receive(:new)
        expect(mock_settings).to receive(:before_starting)
        game.new_players
        expect(game.player_one.name).to eq('New_player_1')
expect(game.instance_variable_get(:@board)).to eq(mock_board)
        expect(game.instance_variable_get(:@player_one)).to eq(new_player_1)
        expect(game.instance_variable_get(:@player_two)).to eq(new_player_2)
        expect(game.instance_variable_get(:@number_of_moves)).to eq(0)
        expect(game.instance_variable_get(:@player)).to eq(new_player_1)
      end
    end
  end
end