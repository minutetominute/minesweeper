require "./tile.rb"

class Board

  SHIFT = [[-1,1], [-1, 0], [-1, -1], [0, 1],
  [0, -1], [1, 1], [1, 0], [1, -1]]

  attr_reader :tiles, :bound_rows, :bound_cols

  def initialize(rows, cols)
    @bound_rows = rows
    @bound_cols = cols
    @tiles = Array.new(@bound_rows) { Array.new(@bound_cols) }
    generate_tiles
  end

  def generate_tiles
    @bound_rows.times do |row|
      @bound_cols.times do |col|
        current_tile = self[[row,col]] || Tile.random_tile([row,col])

        neighbors = get_neighbors(current_tile)

        neighbors.each do |neighbor|
          current_tile.add_neighbor(neighbor)
          self[neighbor.position] ||= neighbor
        end

        self[[row,col]] = current_tile
      end
    end
  end

  def adjacent_positions(pos)
    row, col = pos
    positions = []

    SHIFT.each do |(x, y)|
      positions << [row + x, col + y]
    end

    positions.select { |pos| pos[0].between?(0, @bound_rows - 1) &&
       pos[1].between?(0, @bound_cols - 1)}
  end

  def get_neighbors(tile)
    adjacent_positions(tile.position).map do |pos|
      self[pos] || Tile.random_tile(pos)
    end
  end

  def [](pos)
    row, col = pos
    @tiles[row][col]
  end

  def []=(pos, tile)
    row, col = pos
    @tiles[row][col] = tile
  end

  def won?
    won = true
    @tiles.each do |row|
      row.each do |tile|
        won = false if tile.hidden && !tile.bomb
      end
    end
    won
  end

  def over?
    @tiles.each do |row|
      row.each do |tile|
        return true if tile.bomb && !tile.hidden
      end
    end
    won?
  end

  def update(flag, pos)
    if flag == "r"
      self[pos].reveal
    else
      self[pos].flag
    end
  end

  def reveal_all
    @tiles.each do |row|
      row.each do |cell|
        cell.unhide
      end
    end
  end

end
