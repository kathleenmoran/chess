# frozen_string_literal: true

require_relative 'coordinate'
require_relative 'colorable'

# a player of a chess game
class Player
  include Colorable
  def initialize(color)
    @color = color
  end

  def to_s
    @color.to_s.capitalize
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end

  def own_piece_at_square?(square)
    (white? && square.occupied_by_white?) || (black? && square.occupied_by_black?)
  end

  def select_start_square
    select_square { prompt_piece_selection(self) }
  end

  def select_end_square
    select_square { prompt_move_selection(self) }
  end

  def select_square(&block)
    alpha_coord = yield
    if valid_alpha_coord?(alpha_coord)
      alpha_to_numeric_coord(alpha_coord)
    else
      print_invalid_coord_message(alpha_coord)
      select_square(&block)
    end
  end

  def valid_alpha_coord?(alpha_coord)
    alpha_coord.length == 2 && alpha_coord[0].match?(/[A-Ha-h]/) && alpha_coord[1].match?(/[1-8]/)
  end

  def alpha_to_numeric_coord(alpha_coord)
    Coordinate.new(alpha_coord[0].upcase.ord - 65, alpha_coord[1].to_i - 1)
  end
end

Player.new(:black).select_end_square