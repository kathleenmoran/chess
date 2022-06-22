# frozen_string_literal: true

require_relative 'diagonalable'
require_relative 'plusable'
require_relative 'piece'

# a queen piece
class Queen < Piece
  include Diagonalable
  include Plusable
  def self.handles?(coordinate)
    coordinate.in?(Constants::QUEEN_X_COORDINATES, Constants::NOT_PAWN_Y_COORDINATES)
  end

  def valid_moves(start_coordinate)
    diagonal_valid_moves(start_coordinate) + plus_valid_moves(start_coordinate)
  end

  def to_s
    color_text(' ♛ ', @color)
  end
end
