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
  attr_reader :coordinate
  attr_reader :piece

  def initialize(coordinate)
    @coordinate = coordinate
    @piece = Piece.for(@coordinate)
    @color = square_color(@coordinate)
  end

  def duplicable?
    true
  end

  def deep_dup
    duplicable? ? dup : self
  end

  def ==(other)
    self.class == other.class && @coordinate == other.coordinate
  end

  def eql?(other)
    @coordinate.eql?(other.coordinate)
  end

  def to_s
    color_background(@piece.to_s, @color)
  end

  def occupied?
    @piece.occupant?
  end

  def occupied_by_white?
    @piece.white?
  end

  def occupied_by_black?
    @piece.black?
  end

  def remove_piece
    @piece = NoPiece.new
  end

  def place_piece(new_piece)
    @piece = new_piece
  end

  def valid_moves_of_piece
    @piece.valid_moves(@coordinate)
  end

  def highlight(new_color)
    @color = new_color
  end

  def remove_highlight
    @color = square_color(@coordinate)
  end

  def piece_can_capture_forward?
    @piece.can_capture_forward?
  end

  def move_piece
    @piece.move
  end

  def piece_capturable?
    @piece.capturable?
  end
end
