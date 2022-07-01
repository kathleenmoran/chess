# frozen_string_literal: true

require_relative 'piece'

# a pawn piece
class Pawn < Piece
  def initialize(color, unmoved = true, moved_by_two = false, move_count = 0)
    super(color)
    @unmoved = unmoved
    @moved_by_two = moved_by_two
    @move_count = move_count
  end

  def deep_dup
    Pawn.new(@color, @unmoved, @moved_by_two, @move_count)
  end

  def unmoved?
    @unmoved
  end

  def self.handles?(coordinate)
    coordinate.in?(Constants::PAWN_X_COORDINATES, Constants::PAWN_Y_COORDINATES)
  end

  def valid_moves(start_coordinate)
    moves = [start_coordinate.transform(0, 1 * y_move_sign)]
    moves << start_coordinate.transform(0, 2 * y_move_sign) if unmoved?
    [moves.select(&:valid?)]
  end

  def valid_captures(start_coordinate)
    [start_coordinate.transform(-1, 1 * y_move_sign), start_coordinate.transform(1, 1 * y_move_sign)].select(&:valid?)
  end

  def valid_en_passant_capture(end_coordinate)
    capture_coord = end_coordinate.transform(0, -1 * y_move_sign)
    return capture_coord if capture_coord.valid?
  end

  def to_s
    color_text(' ♟ ', @color)
  end

  def can_capture_forward?
    false
  end

  def move(start_coord, end_coord, _player)
    @moved_by_two = true if start_coord.moved_two_vertically?(end_coord)
    @move_count += 1
    @unmoved = false
  end

  def capturable_by_en_passant?
    @moved_by_two && @move_count == 1
  end

  def promotable?
    true
  end

  def can_en_passant?
    true
  end
end
