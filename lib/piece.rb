# frozen_string_literal: true

require_relative 'colorable'
require_relative 'constants'

# a chess piece
class Piece
  include Colorable
  def initialize(color)
    @color = color
  end

  def self.for(coordinate)
    class_name = registry.find { |candidate| candidate.handles?(coordinate) }

    class_name ? class_name.new(piece_color(coordinate)) : nil
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

  def self.handles?(coordinate)
    false
  end
  
  def valid_moves(start_coordinate) end

  def valid_captures(start_coordinate) end

  def valid_en_passant_capture(start_coordinate) end

  def to_s() end
end
