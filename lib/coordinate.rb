# frozen_string_literal: true

require_relative 'constants'

# a coordinate that represenets the vertical and horizontal position on a board
class Coordinate
  attr_reader :x, :y

  def initialize(x_coord, y_coord)
    @x = x_coord
    @y = y_coord
  end

  def transform(x_increment, y_increment)
    Coordinate.new(@x + x_increment, @y + y_increment)
  end

  def ==(other)
    self.class == other.class && @x == other.x && @y == other.y
  end

  def valid?
    @x.between?(0, Constants::BOARD_DIMENSION - 1) && @y.between?(0, Constants::BOARD_DIMENSION - 1)
  end

  def min_coordinate
    @x < @y ? @x : @y
  end

  def past_x?(other)
    @x > other.x
  end

  def past_y?(other)
    @y > other.y
  end
end
