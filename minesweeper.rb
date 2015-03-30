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
      input = gets_user_input
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

  def display
    @board.bound_rows.times do |i|
      print "\n"
      @board.bound_cols.times do |j|
        if @board[[i, j]].bomb
          print 1
        else
          print 0
        end
      end
    end
  end
end
