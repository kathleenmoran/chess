# frozen_string_literal: true

# a king piece
class King
  def valid_moves(start_coordinate)
    coordinate_permutations = [-1, 0, 1].repeated_permutation(2).to_a.reject { |perm| perm[0].zero? && perm[1].zero? }
    coordinates = coordinate_permutations.map { |perm| [start_coordinate.transform(perm[0], perm[1])] }
    coordinates.select { |move_array| move_array.first.valid? }
  end
end
