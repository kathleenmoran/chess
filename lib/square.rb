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

  def initialize(coordinate, piece = Piece.for(coordinate))
    @coordinate = coordinate
    @piece = piece
    @color = square_color(@coordinate)
  end

  def deep_dup
    Square.new(@coordinate.deep_dup, @piece.deep_dup)
  end

  def ==(other)
    self.class == other.class && @coordinate == other.coordinate
  end

  def piece_color
    return :white if occupied_by_white?
    return :black if occupied_by_black?
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

  def unmoved?
    @piece.unmoved?
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

  def move_piece(start_coord, end_coord, player)
    @piece.move(start_coord, end_coord, player)
  end

  def piece_capturable?
    @piece.capturable?
  end

  def valid_piece_captures
    @piece.valid_captures(@coordinate)
  end

  def piece_promotable?
    @piece.promotable? && ((@coordinate.in_first_row? && occupied_by_black?) || (@coordinate.in_last_row? && occupied_by_white?))
  end

  def en_passant_capture_square?
    @piece.moved_by_two?
  end

  def piece_valid_en_passant_capture
    @piece.valid_en_passant_capture(@coordinate)
  end

  def promote_piece
    new_piece = Piece.promotion(prompt_promotion_selection.downcase, piece_color)
    if new_piece.nil?
      print_invalid_promotion_message
      promote_piece
    else
      @piece = new_piece
    end
  end
end
