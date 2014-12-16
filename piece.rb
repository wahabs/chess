class Piece

  attr_reader :color

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def moves
  end

  def displace(position, delta)
    [position[0] + delta[0], position[1] + delta[1]]
  end

end
