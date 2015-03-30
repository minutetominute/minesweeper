require "./board.rb"

class Minesweeper

  def self.load(file_name)
  end

  def self.play(rows = 9, cols = 9)
    game = Minesweeper.new(rows, cols)
    game.run
  end

  attr_accessor :board

  def initialize(rows = 9, cols = 9)
    @board = Board.new(rows, cols)
  end

  def run
    puts "Welcome to minesweeper!"

    until @board.over?
      puts display
      # debug_display
      puts "\nMake a move with format: 'c'x,y."
      puts "'c' is either r for reveal, or f for flag."
      flag, pos = gets_user_input
      @board.update(flag, pos)
    end
    if @board.won?
      puts "YOU WIN!!!!!"
    else
      @board.reveal_all
      puts display
      puts "YOU LOSE, YOU DINGUS!"
    end
  end

  def gets_user_input()
    loop do
      initial_input = gets.chomp
      flag = initial_input[0]
      pos = initial_input[1..-1].split(',').map{ |el| el.to_i }
      return [flag, pos] if valid_input?(flag, pos)
      puts "Invalid move. Try again"
    end
  end

  def valid_input?(flag, pos)
    row, col = pos
    max_row, max_col = @board.bound_rows - 1, @board.bound_cols - 1
    pos_check = row.between?(0, max_row) && col.between?(0, max_col)
    flag_check = (flag == "r" || flag == "f")
    pos_check && flag_check
  end

  def display
    str = ""
    @board.bound_rows.times do |i|
      str << "\n-" + ('-' * 2 * @board.bound_rows) + "\n|"
      @board.bound_cols.times do |j|
        str << @board[[i, j]].print+"|"
      end
    end
    str << "\n-" + ('-' * 2 * @board.bound_rows) + "\n"
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
