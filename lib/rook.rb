# frozen_string_literal: true

require_relative 'piece'
require_relative 'plusable'

# a rook piece
class Rook < Piece
  include Plusable
  def self.handles?(coordinate)
    coordinate.in?(Constants::ROOK_X_COORDINATES, Constants::NOT_PAWN_Y_COORDINATES)
  end

  def valid_moves(start_coordinate)
    plus_valid_moves(start_coordinate)
  end

  def to_s
    color_text(' ♜ ', @color)
  end

  def deep_dup
    Rook.new(@color)
  end
end
