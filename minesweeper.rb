require "./board.rb"

class Minesweeper

  def self.load(file_name)
  end

  def self.play
    game = Minesweeper.new
    game.run
  end

  def initiliaze(rows = 9, cols = 9)
    @board = Board.new(rows, cols)
  end

  def run
    until @board.over?
      puts display
      puts "Make a move"



    end
  end

  def gets_user_input()
    loop do
      input = gets.chomp
      break if valid_input?(input)
      puts "Invalid move. Try again"
    end
  end

  def valid_input?(input)
    return true
  end
end
