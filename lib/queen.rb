# frozen_string_literal: true

require_relative 'diagonalable'
require_relative 'plusable'

# a queen piece
class Queen
  include Diagonalable
  include Plusable
  def initialize() end

  def valid_moves(start_coordinate)
    diagonal_valid_moves(start_coordinate) + plus_valid_moves(start_coordinate)
  end
end
