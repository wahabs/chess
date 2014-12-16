require_relative 'sliding_piece'

class Bishop < SlidingPiece


  def moves(deltas = diagonal_deltas)
    super
  end

end
