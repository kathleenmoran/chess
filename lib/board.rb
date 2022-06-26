# frozen_string_literal: true

require_relative 'square'
require_relative 'constants'
require_relative 'coordinate'
require_relative 'player'
require_relative 'colorable'

# a chessboard
class Board
  include Colorable
  def initialize(board = make_board)
    @board = board
  end

  def duplicable?
    true
  end

  def deep_dup
    duplicable? ? dup : self
  end

  def to_s
    @board.reverse.map(&:join).join("\n")
  end

  def valid_move?(start_coordinate, end_coordinate, player)
    player.own_piece_at_square?(find_square(start_coordinate)) &&
      reachable_squares(start_coordinate, player).include?(find_square(end_coordinate))
  end

  def make_board
    (0...Constants::BOARD_DIMENSION).to_a.map { |y_coord| make_row(y_coord) }
  end

  def reachable_squares(coordinate, player)
    piece_square = find_square(coordinate)
    piece_square
      .valid_moves_of_piece
      .reduce([]) do |filtered_moves, path|
        filtered_moves + reachable_squares_in_a_path(path, player, piece_square)
      end
  end

  def filter_illegal_moves(start_square, move_squares, player)
    move_squares.reject do |square|
      p 'hello'
      new_board = deep_dup
      new_board.move_piece(start_square.coordinate, square.coordinate)
      new_board.check?(player)
    end
  end

  def reachable_squares_in_a_path(path, player, piece_square)
    squares = []
    path.each do |coordinate|
      square = find_square(coordinate)
      if square.occupied?
        squares << square if valid_move_with_piece?(player, square, piece_square)
        break
      end
      squares << square
    end
    squares
  end

  def valid_move_with_piece?(player, square, piece_square)
    !player.own_piece_at_square?(square) &&
      piece_square.piece_can_capture_forward?
  end

  def find_king_square(player)
    @board.each do |row|
      row.each do |square|
        return square if player.own_piece_at_square?(square) && !square.piece_capturable?
      end
    end
  end

  def check?(player, opponent, kings_square = find_king_square(player))
    @board.any? do |row|
      row.any? do |square|
        opponent.own_piece_at_square?(square) && reachable_squares(square.coordinate, opponent).include?(kings_square)
      end
    end
  end

  def valid_king_move?(coordinate, player, opponent)
    !check?(player, opponent, find_square(coordinate))
  end

  def color_king(player, opponent)
    check?(player, opponent) ? highlight_king(player) : unhighlight_king(player)
  end

  def highlight_king(player)
    find_king_square(player).highlight(:red)
  end

  def unhighlight_king(player)
    find_king_square(player).remove_highlight
  end

  def checkmate?(player, opponent)
    check?(player, opponent) && king_has_no_valid_moves?(player, opponent)
  end

  def stalemate?(player, opponent)
    !check?(player, opponent) && king_has_no_valid_moves?(player, opponent)
  end

  def king_has_no_valid_moves?(player, opponent)
    valid_move_squares = reachable_squares(find_king_square(player).coordinate, player, opponent)
    valid_move_squares.all? { |square| check?(player, opponent, square) }
  end

  def select_piece(coord, player)
    highlight_piece_and_moves(find_square(coord), reachable_squares(coord, player))
  end

  def deselect_piece(coord, player)
    remove_square_highlights([find_square(coord)] + reachable_squares(coord, player))
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

  def move_piece(start_coord, end_coord)
    start_square = find_square(start_coord)
    end_square = find_square(end_coord)
    end_square.place_piece(start_square.piece)
    start_square.remove_piece
    end_square.move_piece
  end

  def valid_start_square?(coordinate, player)
    player.own_piece_at_square?(find_square(coordinate)) && !reachable_squares(coordinate, player).empty?
  end

  private

  def make_row(y_coord)
    (0...Constants::BOARD_DIMENSION).to_a.map { |x_coord| Square.new(Coordinate.new(x_coord, y_coord)) }
  end
end
