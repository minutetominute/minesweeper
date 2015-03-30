class Tile
  def self.random_tile(pos)
    tile = Tile.new(pos, Tile.random_bomb, [], nil)
  end

  def self.random_bomb
    rand(2) == 0
  end

  def initiliaze(pos, bomb, neighbors, state)
    @position = pos
    @bomb = bomb
    @neighbors = neighbors
    @state = state
  end

  def add_neighbor(neighbor)
    @neighbors << neighbor
  end
end
