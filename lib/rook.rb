# frozen_string_literal: true

require_relative 'coordinate'

# a rook piece
class Rook
  include Plusable
  def initialize() end
  
  def valid_moves(start_coordinate)
    plus_valid_moves(start_coordinate)
  end
end
