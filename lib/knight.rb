# frozen_string_literal: true

require_relative 'coordinate'

# a knight piece
class Knight
  def initialize() end

  def valid_moves(start_coordinate)
    coordinate_permutations = [-2, -1, 1, 2].permutation(2).to_a.reject { |perm| perm[0].abs == perm[1].abs }
    coordinates = coordinate_permutations.map { |perm| [start_coordinate.transform(perm[0], perm[1])] }
    coordinates.select { |move_array| move_array.first.valid? }
  end
end
