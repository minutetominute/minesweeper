class Tile
  def self.random_tile(pos)
    Tile.new(pos, Tile.random_bomb, [], true)
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
    unhide
    return if neighbors.any?(&:bomb)
    neighbors.select(&:hidden).each(&:reveal)
  end

  def print
    if self.flagged
      "F"
    elsif hidden
      "*"
    elsif self.bomb
      "B"
    else
      num = neighbors.count {|neighbor| neighbor.bomb}
      return " " if num == 0
      num.to_s
    end
  end

  def unhide
    self.hidden = false
  end

  def flag
    self.flagged = !self.flagged
  end
end
