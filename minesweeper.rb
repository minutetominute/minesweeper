require "./board.rb"

class Minesweeper

  def self.load(file_name)
  end

  def self.play
    game = Minesweeper.new
    game.run
  end

  attr_accessor :board

  def initialize(rows = 9, cols = 9)
    @board = Board.new(rows, cols)
    @board.generate_tiles
  end

  def run
    puts "Welcome to minesweeper!"
    until @board.over?
      puts display
      debug_display
      puts "\nMake a move with format: +x,+y"
      input = gets_user_input
      @board.update(input)
    end
  end

  def gets_user_input()
    input = nil
    loop do
      input = gets.chomp
      input = input.split(',').map { |n| n.to_i }
      return input if valid_input?(input)
      puts "Invalid move. Try again"
    end
  end

  def valid_input?(input)
    row, col = input
    max_row = @board.bound_rows - 1
    max_col = @board.bound_cols - 1
    row.between?(0, max_row) && col.between?(0, max_col)
  end

  def display
    str = ""
    @board.bound_rows.times do |i|
      str << "\n"
      @board.bound_cols.times do |j|
        str << @board[[i, j]].print
      end
    end
    str
  end

  def debug_display
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
