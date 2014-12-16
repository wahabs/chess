require_relative 'sliding_piece'

class Rook < SlidingPiece

  def moves
    orthogonals
  end

end
