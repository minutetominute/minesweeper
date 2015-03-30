require "./tile.rb"
require "byebug"

class Board

  SHIFT = [[-1,1], [-1, 0], [-1, -1], [0, 1], [0, -1], [1, 1], [1, 0], [1, -1]]
  attr_reader :tiles
  def initialize(rows, cols)
    #array of nodes
    @bound_rows = rows
    @bound_cols = cols
    @tiles = Array.new(@bound_rows) { Array.new(@bound_cols) }
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
      positions << [row + x, row + y]
    end

    positions.select { |pos| pos[0].between?(0, @bound_rows - 1) &&
       pos[1].between?(0, @bound_cols - 1)}
  end

  def get_neighbors(tile)

    adjacent_positions(tile.position).map do |pos|
      byebug if pos == [0,0]
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
end
def debugging
  a = Board.new(9, 9)
  a.generate_tiles
  p a.tiles.first[1]
end

debugging
