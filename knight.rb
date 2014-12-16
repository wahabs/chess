require_relative 'stepping_piece'

class Knight < SteppingPiece

  def knight_deltas
    [-1, 1, 2, -2].repeated_permutation(2).to_a.select do |perm|
      perm[0].abs + perm[1].abs == 3
    end
  end

  def moves(deltas = knight_deltas)
    super
  end

end

# b = Board.new
# q = Knight.new("b", b, [3,3])
# q2 = Knight.new("b", b, [5,4])
# b[[3,3]] = q
# b[[5,4]] = q2
# p q.moves
