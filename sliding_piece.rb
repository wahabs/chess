require_relative 'piece'

class SlidingPiece < Piece

  def diagonals
    deltas = [-1,1].repeated_permutation(2).to_a
    sliding_moves(deltas)
  end

  def sliding_moves(deltas)
    potentials = []
    deltas.each do |delta|
      last_move = self.position
      next_move = displace(last_move, delta)
      while @board.move_on_board?(next_move)
        potentials << next_move
        last_move = next_move
        next_move = displace(last_move, delta)
        if @board.location_occupied?(next_move)
          potentials << next_move unless @board[next_move].color == color
          break
        end
      end
    end

    potentials
  end

  def orthogonals
    x, y = @position
    deltas = [[x + 1, y],
    [x - 1, y],
    [x, y + 1],
    [x, y - 1]]
    sliding_moves(deltas)
  end

  def displace(position, delta)
    [position[0] + delta[0], position[1] + delta[1]]
  end


end
