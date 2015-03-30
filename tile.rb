class Tile
  def self.random_tile(pos)
    return Tile.new(pos, Tile.random_bomb, [], nil)
  end

  def self.random_bomb
    rand(2) == 0
  end

  attr_reader :position, :bomb, :neighbors, :state

  def initialize(pos, bomb, neighbors, state)
    @position = pos
    @bomb = bomb
    @neighbors = neighbors
    @state = state
  end

  def add_neighbor(neighbor)
    @neighbors << neighbor
  end
end
