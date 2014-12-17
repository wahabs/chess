require 'byebug'
require_relative 'chess_set'

class NoPieceError < ArgumentError
end

class InvalidMoveError < ArgumentError
end

class InCheckError < ArgumentError
end

class Board
  attr_accessor :grid

  def initialize(initialize_pieces = true)
    @grid = Array.new(8) { Array.new(8) }
    fill_board if initialize_pieces
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
    self[[0, 0]] = Rook.new(:w, self, [0, 0])
    self[[1, 0]] = Knight.new(:w, self, [1, 0])
    self[[2, 0]] = Bishop.new(:w, self, [2, 0])
    self[[3, 0]] = Queen.new(:w, self, [3, 0])
    self[[4, 0]] = King.new(:w, self, [4, 0])
    self[[5, 0]] = Bishop.new(:w, self, [5, 0])
    self[[6, 0]] = Knight.new(:w, self, [6, 0])
    self[[7, 0]] = Rook.new(:w, self, [7, 0])

    self[[0, 7]] = Rook.new(:b, self, [0, 7])
    self[[1, 7]] = Knight.new(:b, self, [1, 7])
    self[[2, 7]] = Bishop.new(:b, self, [2, 7])
    self[[3, 7]] = Queen.new(:b, self, [3, 7])
    self[[4, 7]] = King.new(:b, self, [4, 7])
    self[[5, 7]] = Bishop.new(:b, self, [5, 7])
    self[[6, 7]] = Knight.new(:b, self, [6, 7])
    self[[7, 7]] = Rook.new(:b, self, [7, 7])

    8.times do |i|
      self[[i, 1]] = Pawn.new(:w, self, [i, 1])
      self[[i, 6]] = Pawn.new(:b, self, [i, 6])
    end
  end

  def display_board
    print "  "

    puts ""
    @grid.transpose.each_with_index do |row, r|
      print "#{r} "
      row.each_with_index do |piece, c|
        if piece
          print "#{piece.to_s} "
        else
          print "#{((r+c).even?) ? "□" : "■"} "
        end
      end
      puts ""
    end
    puts "  a b c d e f g h"

  end

  def in_check?(color)
    king_location = nil
    @grid.flatten.each do |piece|
      if piece.is_a?(King) && piece.color == color
        king_location = piece.position
        break
      end
    end

    all_pieces.any? { |piece| piece.moves.include?(king_location) }
  end

  def checkmate?(color)
    color_pieces = all_pieces.select { |piece| piece.color == color }
    color_pieces.each do |piece|
      return false if piece.safe_moves(piece.moves).length > 0
    end
    true
  end

  def move(start_loc, end_loc)
    piece = self[start_loc]

    if piece.nil?
      no_piece = "There's no piece at #{start_loc}"
      raise NoPieceError.new
    end

    if !piece.moves.include?(end_loc)
      invalid_move = "You can't move the #{piece.class} to #{end_loc} \n"\
      "Valid moves are #{piece.moves}"
      raise InvalidMoveError.new invalid_move
    end

    if !piece.safe_moves(piece.moves).include?(end_loc)
      raise InCheckError.new "That move would put you into check"
    end


    self[end_loc] = piece
    self[end_loc].position = end_loc
    self[start_loc] = nil

    display_board
  end

  def move!(start_loc, end_loc)
    if self[start_loc].nil?
      no_piece = "There's no piece at #{start_loc}"
      raise NoPieceError.new no_piece
    end

    self[end_loc] = self[start_loc]
    self[end_loc].position = end_loc
    self[start_loc] = nil
  end

  def dup
    new_board = Board.new(false)
    all_pieces.each do |piece|
      new_piece = piece.class.new(piece.color, new_board, piece.position.dup)
      new_board[new_piece.position] = new_piece
    end
    new_board
  end

  def all_pieces
    @grid.flatten.compact
  end

end




# b = Board.new
#
# b.display_board
#
# b.move([4,1], [4,2])
# b.move([6,6], [6,4])
# b.move([5,6], [5,5])
# b.move([3,0], [7,4])
#
# p b.checkmate?(:w)


# p b.in_check?(:w)
# p b.in_check?(:b)



# q = Pawn.new(:w, b, [3,3])
# q2 = Pawn.new(:b, b, [4,4])
# b[[3,3]] = q
# b[[4,4]] = q2
# p q.moves
