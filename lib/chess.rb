# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'colorable'

# a chess game
class Chess
  include Colorable
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @active_player = @player1
  end

  def play_turn
    start_coord = select_piece
    end_coord = select_move(start_coord)
    @board.move_piece(start_coord, end_coord)
    manage_check_warnings
    puts @board
  end

  def play_game
    puts @board
    loop do
      play_turn
      change_active_player
    end
  end

  def manage_check_warnings
    @board.color_king(@player1, @player2)
    @board.color_king(@player2, @player1)
  end

  def select_piece
    start_coord = @active_player.select_start_square
    if @board.valid_start_square?(start_coord, @active_player)
      @board.select_piece(start_coord, @active_player)
      puts @board
      @board.deselect_piece(start_coord, @active_player)
      start_coord
    else
      print_invalid_start_square_message
      select_piece
    end
  end

  def change_active_player
    @active_player = inactive_player
  end

  def inactive_player
    @active_player == @player1 ? @player2 : @player1
  end

  def select_move(start_coord)
    end_coord = @active_player.select_end_square
    if @board.valid_move?(start_coord, end_coord, @active_player)
      end_coord
    else
      print_invalid_move_message
      select_move(start_coord)
    end
  end
end

the_chess = Chess.new
the_chess.play_game