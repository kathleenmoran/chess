# frozen_string_literal: true

require_relative 'piece'

# a king piece
class King < Piece
  def initialize(color, unmoved = true)
    super(color)
    @unmoved = unmoved
  end

  def self.handles?(coordinate)
    coordinate.in?(Constants::KING_X_COORDINATES, Constants::NOT_PAWN_Y_COORDINATES)
  end

  def deep_dup
    King.new(@color, @unmoved)
  end

  def kingside_castle_move(coord)
    return unless unmoved?

    coord.transform(2, 0)
  end

  def queenside_castle_move(coord)
    return unless unmoved?

    coord.transform(-2, 0)
  end

  def king?
    true
  end

  def unmoved?
    @unmoved
  end

  def valid_moves(start_coordinate)
    coordinate_permutations = [-1, 0, 1].repeated_permutation(2).to_a.reject { |perm| perm[0].zero? && perm[1].zero? }
    coordinates = coordinate_permutations.map { |perm| [start_coordinate.transform(perm[0], perm[1])] }
    coordinates.select { |move_array| move_array.first.valid? }
  end

  def to_s
    color_text(' ♚ ', @color)
  end

  def capturable?
    false
  end

  def move(_start_coord, _end_coord, _player)
    @unmoved = false
  end
end
