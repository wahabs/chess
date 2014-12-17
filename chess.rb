require_relative 'board'

class Chess

  class WrongColorError < ArgumentError
  end

  def self.human_v_human
    Chess.new(b: HumanPlayer.new(:b), w: HumanPlayer.new(:w))
  end

  def initialize(players)
    @board = Board.new
    @players = players
  end

  def toggle_color(color)
    (color == :w) ? :b : :w
  end

  def color_valid?(start_loc, color)
    @board[start_loc].color == color
  end

  def play

    puts "Welcome to Chess."

    @board.display_board
    color = :w

    until @board.checkmate?(color)
      begin
        start_loc, end_loc = @players[color].play_turn
        raise WrongColorError unless color_valid?(start_loc, color)
        @board.move(start_loc, end_loc)
      rescue NoPieceError
        puts "There's no piece at there to move"
        retry
      rescue InCheckError
        puts "That move would put you into check"
        retry
      rescue InvalidMoveError
        puts "The piece can't move there"
        retry
      rescue WrongColorError
        puts "That piece isn't yours!"
        retry
      end

      color = toggle_color(color)
    end

    puts "Checkmate. #{(color == :w) ? "Black" : "White"} wins!"
  end
end

class HumanPlayer
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def play_turn
    puts "#{(color == :w) ? "White" : "Black"}, please enter start and end coordinates."
    columns = {
      "a" => 0,
      "b" => 1,
      "c" => 2,
      "d" => 3,
      "e" => 4,
      "f" => 5,
      "g" => 6,
      "h" => 7
    }
    locations = gets.chomp.split(" ")
    locations.map do |pos|
      [columns[pos[0]], pos[1].to_i]
    end
  end
end

c = Chess.human_v_human
c.play
