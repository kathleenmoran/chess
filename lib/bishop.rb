# frozen_string_literal: true

require_relative 'diagonalable'
require_relative 'coordinate'

# a bishop piece
class Bishop
  include Diagonalable
  def initialize() end

  def valid_moves(start_coordinate)
    diagonal_valid_moves(start_coordinate)
  end
end

p Bishop.new.valid_moves(Coordinate.new(6, 1))
