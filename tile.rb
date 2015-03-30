class Tile
  def self.random_tile(pos)
    return Tile.new(pos, Tile.random_bomb, [], true)
  end

  def self.random_bomb
    rand(5) == 0
  end

  attr_reader :position, :bomb, :neighbors, :hidden

  def initialize(pos, bomb, neighbors, hidden)
    @position = pos
    @bomb = bomb
    @neighbors = neighbors
    @hidden = hidden
    @flagged = false
  end

  def add_neighbor(neighbor)
    @neighbors << neighbor
  end

  def reveal
    hidden = false
    p position
    p hidden
    byebug if neighbors.any? { |neighbor| neighbor.bomb }

    neighbors.select { |n| hidden }.each do |neighbor|
      neighbor.reveal
    end

  end

  def print
    if hidden
       return "*"
    else
      num = neighbors.count {|neighbor| neighbor.bomb}
      return "_" if num == 0
      num.to_s
    end
  end
end
