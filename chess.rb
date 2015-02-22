require_relative 'board'
require_relative 'player'

class Chess

  class WrongColorError < ArgumentError
  end

  def self.human_v_human
    Chess.new(b: HumanPlayer.new(:b), w: HumanPlayer.new(:w)).play
  end

  def self.comp_v_comp
    Chess.new(b: ComputerPlayer.new(:b), w: ComputerPlayer.new(:w)).play
  end

  def self.human_v_comp
    Chess.new(b: HumanPlayer.new(:b), w: ComputerPlayer.new(:w)).play
  end

  def initialize(players)
    @board = Board.new
    @players = players
    players.each do |color, player|
       player.board = @board unless player.is_human?
    end
  end

  def human_playing?
    @players[:b].is_human? || @players[:w].is_human?
  end

  def toggle_color(color)
    (color == :w) ? :b : :w
  end

  def color_valid?(start_loc, color)
    @board[start_loc].color == color
  end

  def play

    puts "Welcome to Chess. NOTE: Depending on your console configuration, colors may be inverted."

    @board.display_board
    color = :w

    until @board.checkmate?(color)
      begin
        player = @players[color]
        start_loc, end_loc = player.play_turn
        raise WrongColorError unless color_valid?(start_loc, color)
        @board.move(start_loc, end_loc)
      rescue NoPieceError
        puts "There's no piece at there to move" if player.is_human?
        retry
      rescue InCheckError
        puts "That move would put you into check" if player.is_human?
        retry
      rescue InvalidMoveError
        puts "The piece can't move there" if player.is_human?
        retry
      rescue WrongColorError
        puts "That piece isn't yours!" if player.is_human?
        retry
      rescue IndexError
        puts "Invalid move." if player.is_human?
        retry
      end

      sleep(0.5)
      color = toggle_color(color)
      system("clear") if player.is_human? || !human_playing?
    end

    puts "Checkmate. #{(color == :w) ? "Black" : "White"} wins!"
  end
end
