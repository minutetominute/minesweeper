class Tile
  def self.random_tile(pos)
    return Tile.new(pos, Tile.random_bomb, [], true)
  end

  def self.random_bomb
    rand(5) == 0
  end

  attr_accessor :position, :bomb, :neighbors, :hidden, :flagged

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
    return if self.flagged
    self.hidden = false

    return if neighbors.any? { |neighbor| neighbor.bomb }
    
    neighbors.select { |n| n.hidden }.each do |neighbor|
      neighbor.reveal
    end

  end

  def print
    if self.flagged
      return "F"
    elsif hidden
      return "*"
    else
      num = neighbors.count {|neighbor| neighbor.bomb}
      return "_" if num == 0
      num.to_s
    end
  end

  def flag
    self.flagged = !self.flagged
  end
end
