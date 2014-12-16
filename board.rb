class Board

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end

  def move_on_board?(position)
    position.all? do |coordinate|
      (0...8).cover?(coordinate)
    end
  end

  def location_occupied?(position)
    !self[position].nil?
  end

  def valid_move?(position)
    move_on_board?(position) || location_occupied?(position))
  end
end


class Bishop < SlidingPiece

  def moves
    diagonals
  end

end

class Rook < SlidingPiece

  def moves
    orthogonals
  end

end

class Queen < SlidingPiece

  def moves
    orthogonals + diagonals
  end

end


class SteppingPiece < Piece

end

class Knight < SteppingPiece
end

class King < SteppingPiece
end

class Pawn < Piece
end
