# frozen_string_literal: true

require_relative 'piece'

# a pawn piece
class Pawn < Piece
  def initialize(color, first_move: true, moved_by_two: false)
    super(color)
    @first_move = first_move
    @moved_by_two = moved_by_two
  end

  def deep_dup
    Pawn.new(@color, @first_move, @moved_by_two)
  end

  def self.handles?(coordinate)
    coordinate.in?(Constants::PAWN_X_COORDINATES, Constants::PAWN_Y_COORDINATES)
  end

  def valid_moves(start_coordinate)
    moves = [start_coordinate.transform(0, 1 * y_move_sign)]
    moves << start_coordinate.transform(0, 2 * y_move_sign) if @first_move
    [moves.select(&:valid?)]
  end

  def valid_captures(start_coordinate)
    [start_coordinate.transform(-1, 1 * y_move_sign), start_coordinate.transform(1, 1 * y_move_sign)].select(&:valid?)
  end

  def valid_en_passant_capture(end_coordinate)
    p 'hello'
    capture_coord = end_coordinate.transform(0, -1 * y_move_sign)
    return capture_coord if capture_coord.valid?
  end

  def to_s
    color_text(' ♟ ', @color)
  end

  def y_move_sign
    black? ? -1 : 1
  end

  def can_capture_forward?
    false
  end

  def move(start_coord, end_coord, player)
    @moved_by_two = true if start_coord.moved_two_vertically?(end_coord) && @first_move == true
    @first_move = false
  end

  def moved_by_two?
    @moved_by_two
  end

  def promotable?
    true
  end
end
