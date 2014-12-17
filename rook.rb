require_relative 'sliding_piece'

class Rook < SlidingPiece

  def moves(deltas = orthogonal_deltas)
    super
  end

  def to_s
    (self.color == :b) ? :♜ : :♖
  end

end

# b = Board.new
# q = Rook.new("b", b, [3,3])
# q2 = Rook.new("w", b, [5,3])
# b[[3,3]] = q
# b[[5,3]] = q2
# p q.moves
