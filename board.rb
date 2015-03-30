require "./tile.rb"

class Board

  SHIFT = [[-1,1], [-1, 0], [-1, -1], [0, 1], [0, -1], [1, 1], [1, 0], [1, -1]]

  def initialize(rows, cols)
    #array of nodes
    @bound_rows = rows
    @bound_cols = cols
    @tiles = Array.new(@bound_rows) { Array.new(@bound_cols) }
  end

  def generate_tiles
    @bounds_rows.times do |row|
      @bound_cols.times do |col|

        current_tile = Tile.random_tile([row,col])
        tiles[row][col] = current_tile

        neighbors = generate(current_tile)

        neighbors.each do |neighbor|
          current_tile.add_neighbor(neighbor)
        end
      end
    end
  end



  def adjacent_positions(pos)
    row, col = pos
    positions = []

    SHIFT.each do |(x, y)|
      positions << [row + x, row + y]
    end

    positions.select { |pos| pos[0].between?(0, @bound_rows) &&
       pos[1].between?(0, @bound_cols)}
  end

  def generate_neighbors(tile)
  end

  def [](pos)
    row, col = pos
    @tiles[row][col]
  end

end
