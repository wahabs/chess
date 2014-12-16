require_relative 'sliding_piece'

class Queen < SlidingPiece

  def moves
    orthogonals + diagonals
  end

end
