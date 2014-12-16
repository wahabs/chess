require 'byebug'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    fill_board
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

  def fill_board
    self[[0, 0]] = Rook.new("w", self, [0, 0])
    self[[1, 0]] = Knight.new("w", self, [1, 0])
    self[[2, 0]] = Bishop.new("w", self, [2, 0])
    self[[3, 0]] = Queen.new("w", self, [3, 0])
    self[[4, 0]] = King.new("w", self, [4, 0])
    self[[5, 0]] = Bishop.new("w", self, [5, 0])
    self[[6, 0]] = Knight.new("w", self, [6, 0])
    self[[7, 0]] = Rook.new("w", self, [7, 0])

    self[[0, 7]] = Rook.new("b", self, [0, 7])
    self[[1, 7]] = Knight.new("b", self, [1, 7])
    self[[2, 7]] = Bishop.new("b", self, [2, 7])
    self[[3, 7]] = Queen.new("b", self, [3, 7])
    self[[4, 7]] = King.new("b", self, [4, 7])
    self[[5, 7]] = Bishop.new("b", self, [5, 7])
    self[[6, 7]] = Knight.new("b", self, [6, 7])
    self[[7, 7]] = Rook.new("b", self, [7, 7])
  end

  def display_board
    p @grid 
  end

  def move(start_loc, end_loc)
    self[end_loc] = self[start_loc]
    self[start_loc] = nil
  end

end


# b = Board.new
# b.display_board
