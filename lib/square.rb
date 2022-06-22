# frozen_string_literal: true

require_relative 'colorable'
require_relative 'piece'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'
require_relative 'no_piece'

# a square on a chessboard
class Square
  include Colorable
  def initialize(coordinate)
    @coordinate = coordinate
    @piece = Piece.for(@coordinate)
    @color = square_color(@coordinate)
  end

  def to_s
    color_background(@piece, @color)
  end
end
