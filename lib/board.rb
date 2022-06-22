# frozen_string_literal: true

require_relative 'square'
require_relative 'constants'
require_relative 'coordinate'

# a chessboard
class Board
  def initialize
    @board = make_board
  end

  def to_s
    @board.reverse.map(&:join).join("\n")
  end

  def make_board
    (0...Constants::BOARD_DIMENSION).to_a.map { |y_coord| make_row(y_coord) }
  end

  def make_row(y_coord)
    (0...Constants::BOARD_DIMENSION).to_a.map { |x_coord| Square.new(Coordinate.new(x_coord, y_coord)) }
  end
end
