# frozen_string_literal: true

require_relative 'piece'
require_relative 'plusable'

# a rook piece
class Rook < Piece
  include Plusable
  def initialize(color, first_move: true)
    super(color)
    @first_move = first_move
  end

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
    Rook.new(@color, @first_move)
  end

  def unmoved?
    @first_move
  end

  def move(start_coord, end_coord, player)
    @first_move = false
  end
end
