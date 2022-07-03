# frozen_string_literal: true

require_relative 'displayable'
require_relative 'constants'

# a chess piece
class Piece
  include Displayable
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end

  def self.for(coordinate)
    registry.find { |candidate| candidate.handles?(coordinate) }.new(piece_color(coordinate))
  end

  def self.promotion(user_input, piece_color)
    piece_class = registry.find { |candidate| candidate.handles_promotion?(user_input) }
    piece_class ? piece_class.new(piece_color) : nil
  end

  def king?
    false
  end

  def capturable_by_en_passant?
    false
  end

  def self.piece_color(coordinate)
    if coordinate.y_between?(0, 1)
      :white
    elsif coordinate.y_between?(6, 7)
      :black
    end
  end

  def self.registry
    @registry ||= [Piece]
  end

  def self.register(candidate)
    registry.prepend(candidate)
  end

  def self.inherited(candidate) 
    register(candidate)
  end

  def self.handles?(_coordinate)
    false
  end

  def self.handles_promotion?(_user_input)
    false
  end

  def occupant?
    true
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end

  def can_capture_forward?
    true
  end

  def valid_moves(_start_coordinate)
    []
  end

  def valid_captures(_start_coordinate)
    []
  end

  def en_passant_coord(end_coord, start_square)
    coord = end_coord.transform(0, -1 * start_square.piece_y_move_sign)
    return unless coord.valid?

    coord
  end

  def can_en_passant?
    false
  end

  def y_move_sign
    black? ? -1 : 1
  end

  def valid_en_passant_capture(end_coord) end

  def move(start_coord, end_coord, player) end

  def capturable?
    true
  end

  def promotable?
    false
  end

  def unmoved?
    false
  end

  def kingside_castle_move(coord) end

  def queenside_castle_move(coord) end
end
