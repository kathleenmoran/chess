# frozen_string_literal: true

require_relative 'square'
require_relative 'constants'
require_relative 'coordinate'
require_relative 'player'

# a chessboard
class Board
  def initialize(board = make_board)
    @board = board
  end

  def to_s
    @board.reverse.map(&:join).join("\n")
  end

  def valid_move?(start_coordinate, end_coordinate, player)
    player.own_piece_at_square?(find_square(start_coordinate)) &&
      reachable_moves(start_coordinate, player).include?(end_coordinate)
  end

  def make_board
    (0...Constants::BOARD_DIMENSION).to_a.map { |y_coord| make_row(y_coord) }
  end

  def reachable_squares(coordinate, player)
    piece_square = find_square(coordinate)
    piece_square
      .valid_moves_of_piece
      .reduce([]) { |filtered_moves, path| filtered_moves + reachable_squares_in_a_path(path, player, piece_square) }
  end

  def reachable_squares_in_a_path(path, player, piece_square)
    squares = []
    path.each do |coordinate|
      square = find_square(coordinate)
      if square.occupied?
        squares << square unless player.own_piece_at_square?(square) && piece_square.piece_can_capture_forward?
        break
      end
      squares << square
    end
    squares
  end

  def select_piece(coord, player)
    highlight_piece_and_moves(find_square(coord), reachable_squares(coord, player))
  end

  def highlight_piece_and_moves(piece_square, move_squares)
    piece_square.highlight(:yellow)
    move_squares.map { |square| square.highlight(:neon_green) }
  end

  def remove_square_highlights(squares)
    squares.map(&:remove_highlight)
  end

  def find_squares(coordinates)
    coordinates.map { |coordinate| find_square(coordinate) }
  end

  def find_square(coordinate)
    @board[coordinate.y][coordinate.x]
  end

  def move_piece(start_square, end_square)
    end_square.place_piece(start_square.piece)
    start_square.remove_piece
    end_square.move_piece
  end

  private

  def make_row(y_coord)
    (0...Constants::BOARD_DIMENSION).to_a.map { |x_coord| Square.new(Coordinate.new(x_coord, y_coord)) }
  end
end
