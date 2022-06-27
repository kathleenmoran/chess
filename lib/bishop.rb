# frozen_string_literal: true

require_relative 'diagonalable'
require_relative 'piece'

# a bishop piece
class Bishop < Piece
  include Diagonalable
  def valid_moves(start_coordinate)
    diagonal_valid_moves(start_coordinate)
  end

  def deep_dup
    Bishop.new(@color)
  end

  def self.handles?(coordinate)
    coordinate.in?(Constants::BISHOP_X_COORDINATES, Constants::NOT_PAWN_Y_COORDINATES)
  end

  def to_s
    color_text(' ♝ ', @color)
  end
end
