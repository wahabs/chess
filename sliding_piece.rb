require_relative 'piece'
require 'byebug'


class SlidingPiece < Piece



  def moves(deltas)
    potentials = []
    deltas.each do |delta|
      last_move = self.position
      next_move = displace(last_move, delta)
      while @board.move_on_board?(next_move)
        potentials << next_move
        last_move = next_move
        next_move = displace(last_move, delta)
        if @board.location_occupied?(next_move)
          potentials << next_move if can_take?(next_move)
          break
        end
      end
    end

    potentials
  end

end
