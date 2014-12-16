require_relative 'stepping_piece'

class King < SteppingPiece

  def moves(deltas = orthogonal_deltas + diagonal_deltas)
    super
  end


end


# b = Board.new
# q = King.new("b", b, [3,3])
# q2 = King.new("b", b, [4,3])
# b[[3,3]] = q
# b[[4,3]] = q2
# p q.moves
