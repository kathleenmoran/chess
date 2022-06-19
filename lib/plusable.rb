# frozen_string_literal: true

require_relative 'constants'

# ability to move vertically and horizontally
module Plusable
  def plus_valid_moves(start_coordinate)
    [
      above_valid_moves(start_coordinate), below_valid_moves(start_coordinate),
      left_valid_moves(start_coordinate), right_valid_moves(start_coordinate)
    ]
  end

  def above_valid_moves(start_coordinate)
    (1...Constants::BOARD_DIMENSION - start_coordinate.y).map { |y| start_coordinate.transform(0, y) }
  end

  def below_valid_moves(start_coordinate)
    (-start_coordinate.y...0).map { |y| start_coordinate.transform(0, y) }.reverse
  end

  def left_valid_moves(start_coordinate)
    (-start_coordinate.x...0).map { |x| start_coordinate.transform(x, 0) }.reverse
  end

  def right_valid_moves(start_coordinate)
    (1...Constants::BOARD_DIMENSION - start_coordinate.x).map { |x| start_coordinate.transform(x, 0) }
  end
end
