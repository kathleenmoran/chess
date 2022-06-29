# frozen_string_literal: true

require_relative 'coordinate'
require_relative 'colorable'

# a player of a chess game
class Player
  include Colorable
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def to_s
    @color.to_s.capitalize
  end

  def checked?
    @checked
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end

  def queenside_rook_coord
    Coordinate.new(0, piece_row)
  end

  def kingside_rook_coord
    Coordinate.new(7, piece_row)
  end

  def piece_row
    if white?
      0
    elsif black?
      7
    end
  end

  def own_piece_at_square?(square)
    (white? && square.occupied_by_white?) || (black? && square.occupied_by_black?)
  end

  def does_not_own_piece_at_square?(square)
    (white? && square.occupied_by_black?) || (black? && square.occupied_by_white?)
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
