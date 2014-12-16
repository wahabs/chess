require_relative 'sliding_piece'

class Bishop < SlidingPiece

  def moves
    diagonals
  end

end
