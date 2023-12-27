class ConnectFour
  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @current_player = 'X'
  end

  def print_board
    @board.each { |row| puts row.join('|') }
    puts '---------------'
  end

  def valid_move?(column)
    @board[0][column] == ' '
  end

  def drop_piece(column)
    row = 5
    row -= 1 while row >= 0 && @board[row][column] != ' '
    @board[row][column] = @current_player
  end

  def switch_player
    @current_player = (@current_player == 'X') ? 'O' : 'X'
  end

  def win?(row, column)
    # Implement logic to check for a win
  end

  def game_over?
    # Implement logic to check for a win or a tie
  end

  def player_move
    puts "#{@current_player}'s turn. Enter column (0-6):"
    column = gets.chomp.to_i

    until valid_move?(column)
      puts 'Invalid move. Please choose another column:'
      column = gets.chomp.to_i
    end

    drop_piece(column)
  end

  def computer_move
    # Implement computer's move logic (random or strategic)
  end

  def play
    loop do
      print_board
      @current_player == 'X' ? player_move : computer_move
      break if game_over?

      switch_player
    end

    print_board
    puts 'Game over!'
  end
end

ConnectFour.new.play
