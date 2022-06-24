# frozen_string_literal: true

# a player of a chess game
class Player
  def initialize(color)
    @color = color
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end

  def own_piece_at_square?(square)
    (white? && square.occupied_by_white?) || (black? && square.occupied_by_black?)
  end
end
