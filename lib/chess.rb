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
    @draw = false
  end

  def play_turn
    start_coord = select_piece
    return if @draw

    end_coord = select_move(start_coord)
    return if @draw

    @board.update_with_move(start_coord, end_coord, @active_player)
    manage_check_warnings
    puts @board
  end

  def play_game
    puts @board
    until @board.checkmate?(@active_player, inactive_player) || @board.stalemate?(@active_player, inactive_player)
      play_turn
      break if @draw

      change_active_player
      print_check_message(@active_player) if @board.check?(@active_player, inactive_player)
    end
    puts @board
    print_end_game_message
  end

  def print_end_game_message
    if @board.checkmate?(@active_player, inactive_player)
      print_win_message(inactive_player)
    elsif @board.stalemate?(@active_player, inactive_player)
      print_stalemate_message
    else
      print_draw_message
    end
  end

  def manage_check_warnings
    @board.color_king(@player1, @player2)
    @board.color_king(@player2, @player1)
  end

  def select_piece
    start_coord = @active_player.select_start_square(inactive_player)
    if start_coord == 'draw'
      @draw = true
    elsif @board.valid_start_square?(start_coord, @active_player, inactive_player)
      @board.select_piece(start_coord, @active_player, inactive_player)
      puts @board
      @board.deselect_piece(start_coord, @active_player, inactive_player)
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
    end_coord = @active_player.select_end_square(inactive_player)
    if end_coord == 'draw'
      @draw = true
    elsif @board.valid_move?(start_coord, end_coord, @active_player, inactive_player)
      end_coord
    else
      print_invalid_move_message
      select_move(start_coord)
    end
  end
end

the_chess = Chess.new
the_chess.play_game
