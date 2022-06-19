# frozen_string_literal: true

require_relative 'constants'

# ability to move diagonally
module Diagonalable
  def diagonal_valid_moves(start_coordinate)
    left_diagonal_valid_moves(start_coordinate) + right_diagonal_valid_moves(start_coordinate)
  end

  def left_diagonal_valid_moves(start_coordinate)
    min = start_coordinate.min_coordinate
    top = []
    bottom = []
    Constants::BOARD_DIMENSION.times do |i|
      coord = start_coordinate.transform(i - min, i - min)
      next unless coord.valid?

      if coord.past_x?(start_coordinate)
        bottom << coord
      elsif coord != start_coordinate
        top << coord
      end
    end
    [top.reverse, bottom]
  end

  def right_diagonal_valid_moves(start_coordinate)
    top = []
    bottom = []
    Constants::BOARD_DIMENSION.times do |i|
      coord = start_coordinate.transform(i - start_coordinate.x, start_coordinate.x - i)
      next unless coord.valid?

      if coord.past_y?(start_coordinate)
        bottom << coord
      elsif coord != start_coordinate
        top << coord
      end
    end
    [top, bottom.reverse]
  end
end
