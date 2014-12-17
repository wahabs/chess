require_relative 'sliding_piece'

class Queen < SlidingPiece

  def moves(deltas = orthogonal_deltas + diagonal_deltas)
    super
  end

  def to_s
    (self.color == :b) ? :♛ : :♕
  end

end
#
# b = Board.new
# q = Queen.new("b", b, [3,3])
# q2 = Queen.new("w", b, [5,5])
# b[[3,3]] = q
# b[[5,5]] = q2
# p q.moves
