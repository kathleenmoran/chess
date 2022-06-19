# frozen_string_literal: true

require_relative 'diagonalable'

# a bishop piece
class Bishop
  include Diagonalable
  def initialize() end

  def valid_moves(start_coordinate)
    diagonal_valid_moves(start_coordinate)
  end
end
