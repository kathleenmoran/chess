# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'displayable'
require 'yaml'

# a chess game
class Chess
  include Displayable
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @active_player = @player1
    @draw = false
    @save = false
    @quit = false
    @file_name = nil
  end

  def play_turn
    start_coord = select_piece
    return if @draw || @save || @quit

    end_coord = select_move(start_coord)
    return if @draw || @save || @quit

    @board.update_with_move(start_coord, end_coord, @active_player)
    manage_check_warnings
    puts @board
  end

  def play_game
    puts @board
    until @board.checkmate?(@active_player, inactive_player) || @board.stalemate?(@active_player, inactive_player)
      play_turn
      break if @draw || @save || @quit

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
    elsif @save
      @save = false
      save
    elsif @quit
      print_quit_game_message(@active_player, inactive_player)
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
    elsif start_coord == 'save'
      @save = true
    elsif start_coord == 'quit'
      @quit = true
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
    elsif end_coord == 'save'
      @save = true
    elsif end_coord == 'quit'
      @quit = true
    elsif @board.valid_move?(start_coord, end_coord, @active_player, inactive_player)
      end_coord
    else
      print_invalid_move_message
      select_move(start_coord)
    end
  end

  def save
    @save = false
    @file_name = "saved_games/game_#{Dir['saved_games/*.yaml'].length}.yaml" if @file_name.nil?
    file = File.open(@file_name, 'w')
    file.puts YAML.dump(self)
    file.close
    print_save_game_message(@file_name.split('/')[-1])
  end
end
