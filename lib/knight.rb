# frozen_string_literal: true

require_relative 'piece'

# a knight piece
class Knight < Piece
  def self.handles?(coordinate)
    coordinate.in?(Constants::KNIGHT_X_COORDINATES, Constants::NOT_PAWN_Y_COORDINATES)
  end

  def self.handles_promotion?(user_input)
    user_input == 'knight'
  end

  def deep_dup
    Knight.new(@color)
  end

  def valid_moves(start_coordinate)
    coordinate_permutations = [-2, -1, 1, 2].permutation(2).to_a.reject { |perm| perm[0].abs == perm[1].abs }
    coordinates = coordinate_permutations.map { |perm| [start_coordinate.transform(perm[0], perm[1])] }
    coordinates.select { |move_array| move_array.first.valid? }
  end

  def to_s
    color_text(' ♞ ', @color)
  end
end
