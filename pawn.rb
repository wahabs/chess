require_relative 'piece'

class Pawn < Piece

  def initialize(color, board, position)
    super
    @start_position = position
  end

  def moves
    potentials = []
    deltas = []

    if color == :w
      deltas += [[0, 1], [-1, 1], [1, 1]]
    else
      deltas += [[0, -1], [-1, -1], [1, -1]]
    end


    deltas.each do |delta|
      move = displace(position, delta)
      next unless @board.move_on_board?(move)
      if delta[0] == 0
        next if @board.location_occupied?(move)
        if position = @start_position
          double_move = displace(move, delta)
          potentials << double_move unless @board.location_occupied?(double_move)
        end
        potentials << move
      else # diagonal move
        potentials << move if @board.location_occupied?(move) && can_take?(move)
      end
    end

    potentials
  end

  def to_s
    (self.color == :b) ? :♟ : :♙
  end

end
