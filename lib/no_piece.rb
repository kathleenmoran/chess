# frozen_string_literal: true

require_relative 'piece'

# a nonexistent piece
class NoPiece < Piece
  def self.handles?(coordinate)
    coordinate.in?((0..7).to_a, (2..5).to_a)
  end

  def to_s
    '   '
  end
end
