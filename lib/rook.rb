# frozen_string_literal: true

require_relative 'piece'
require_relative 'plusable'

# a rook piece
class Rook < Piece
  include Plusable
  def initialize(color, unmoved = true)
    super(color)
    @unmoved = unmoved
  end

  def kingside_castle_move(start_coord)
    start_coord.transform(-2, 0)
  end

  def queenside_castle_move(coord)
    coord.transform(3, 0)
  end

  def self.handles?(coordinate)
    coordinate.in?(Constants::ROOK_X_COORDINATES, Constants::NOT_PAWN_Y_COORDINATES)
  end

  def self.handles_promotion?(user_input)
    user_input == 'rook'
  end

  def valid_moves(start_coord)
    plus_valid_moves(start_coord)
  end

  def to_s
    color_text(' ♜ ', @color)
  end

  def deep_dup
    Rook.new(@color, @unmoved)
  end

  def unmoved?
    @unmoved
  end

  def move(_start_coord, _end_coord, _player)
    @unmoved = false
  end
end
