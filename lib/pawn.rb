# frozen_string_literal: true

require_relative 'piece'

# a pawn piece
class Pawn < Piece
  def initialize(color, first_move: true)
    super(color)
    @first_move = first_move
  end

  def self.handles?(coordinate)
    coordinate.in?(Constants::PAWN_X_COORDINATES, Constants::PAWN_Y_COORDINATES)
  end

  def valid_moves(start_coordinate)
    moves = [start_coordinate.transform(0, 1)]
    moves << start_coordinate.transform(0, 2) if @first_move
    [moves.select(&:valid?)]
  end

  def valid_captures(start_coordinate)
    [start_coordinate.transform(-1, 1), start_coordinate.transform(1, 1)].select(&:valid?)
  end

  def valid_en_passant_capture(end_coordinate)
    capture_coord = end_coordinate.transform(0, -1)
    return capture_coord if capture_coord.valid?
  end

  def to_s
    color_text(' ♟ ', @color)
  end
end
