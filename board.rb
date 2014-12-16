require 'byebug'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def [](pos)
  #  byebug
    x, y = pos
    @grid[x][y]
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


end
