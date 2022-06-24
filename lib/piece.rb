# frozen_string_literal: true

require_relative 'colorable'
require_relative 'constants'

# a chess piece
class Piece
  include Colorable
  def initialize(color = nil)
    @color = color
  end

  def self.for(coordinate)
    registry.find { |candidate| candidate.handles?(coordinate) }.new(piece_color(coordinate))
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

  def valid_en_passant_capture(start_coordinate) end

  def move() end
end
