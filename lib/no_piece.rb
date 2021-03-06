# frozen_string_literal: true

require_relative 'piece'

# a nonexistent piece
class NoPiece < Piece
  def self.handles?(coordinate)
    coordinate.in?((0..7).to_a, (2..5).to_a)
  end

  def deep_dup
    NoPiece.new(@color)
  end

  def to_s
    '   '
  end

  def occupant?
    false
  end
end
