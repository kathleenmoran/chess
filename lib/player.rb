# frozen_string_literal: true

require_relative 'coordinate'
require_relative 'displayable'

# a player of a chess game
class Player
  include Displayable
  def initialize(color)
    @color = color
  end

  def to_s
    @color.to_s.capitalize
  end

  def queenside_rook_coord
    Coordinate.new(0, piece_row)
  end

  def queenside_castle_path
    [Coordinate.new(3, piece_row), Coordinate.new(2, piece_row), Coordinate.new(1, piece_row)]
  end

  def kingside_castle_path
    [Coordinate.new(5, piece_row), Coordinate.new(6, piece_row)]
  end

  def kingside_rook_coord
    Coordinate.new(7, piece_row)
  end

  def own_piece_at_square?(square)
    (white? && square.occupied_by_white?) || (black? && square.occupied_by_black?)
  end

  def does_not_own_piece_at_square?(square)
    (white? && square.occupied_by_black?) || (black? && square.occupied_by_white?)
  end

  def select_start_square(opponent)
    select_square(opponent) { prompt_piece_selection(self) }
  end

  def select_end_square(opponent)
    select_square(opponent) { prompt_move_selection(self) }
  end

  def select_square(opponent, &block)
    alpha_coord = yield(opponent).downcase
    if valid_alpha_coord?(alpha_coord)
      alpha_to_numeric_coord(alpha_coord)
    elsif alpha_coord == 'save' || alpha_coord == 'quit' || (alpha_coord == 'draw' && opponent_draw_response(opponent) == 'draw')
      alpha_coord
    elsif alpha_coord == 'draw'
      select_square(opponent, &block)
    else
      print_invalid_coord_message(alpha_coord)
      select_square(opponent, &block)
    end
  end

  private

  def opponent_draw_response(opponent)
    opponent_response = prompt_opponent_for_draw_response(opponent).downcase
    if %w[y yes].include?(opponent_response)
      'draw'
    elsif %w[n no].include?(opponent_response)
      'no draw'
    else
      print_invalid_response_message
      opponent_draw_response(opponent)
    end
  end

  def valid_alpha_coord?(alpha_coord)
    alpha_coord.length == 2 && alpha_coord[0].match?(/[A-Ha-h]/) && alpha_coord[1].match?(/[1-8]/)
  end

  def alpha_to_numeric_coord(alpha_coord)
    Coordinate.new(alpha_coord[0].upcase.ord - 65, alpha_coord[1].to_i - 1)
  end

  def piece_row
    if white?
      0
    elsif black?
      7
    end
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end
end
