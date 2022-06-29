# frozen_string_literal: true

require_relative 'square'
require_relative 'constants'
require_relative 'coordinate'
require_relative 'player'
require_relative 'colorable'

# a chessboard
class Board
  include Colorable
  def initialize(squares = make_board, en_passant_squares = [])
    @squares = squares
    @en_passant_squares = en_passant_squares
  end

  def deep_dup
    Board.new(deep_dup_board, deep_dup_en_passants)
  end

  def deep_dup_board
    @squares.map do |row|
      row.map(&:deep_dup)
    end
  end

  def deep_dup_en_passants
    @en_passant_squares.map(&:deep_dup)
  end

  def to_s
    @squares.reverse.map(&:join).join("\n")
  end

  def valid_move?(start_coordinate, end_coordinate, player)
    player.own_piece_at_square?(find_square(start_coordinate)) &&
      legal_moves(start_coordinate, player).include?(find_square(end_coordinate))
  end

  def make_board
    (0...Constants::BOARD_DIMENSION).to_a.map { |y_coord| make_row(y_coord) }
  end

  def legal_moves(coordinate, player)
    reachable_squares(coordinate, player).select(&:piece_capturable?)
  end

  def reachable_squares(coordinate, player)
    piece_square = find_square(coordinate)
    squares = piece_square
      .valid_moves_of_piece
      .reduce([]) do |filtered_moves, path|
        filtered_moves + reachable_squares_in_a_path(path, player, piece_square)
      end + diagonal_captures(piece_square, player)
    squares << find_square(find_king_square(player).coordinate.transform(-2, 0)) if !find_square(coordinate).piece_capturable? && can_castle_queenside?(player)
    squares << find_square(find_king_square(player).coordinate.transform(2, 0)) if !find_square(coordinate).piece_capturable? && can_castle_kingside?(player) 
    squares
  end

  def diagonal_captures(piece_square, player)
    piece_square.valid_piece_captures.map { |coordinate| find_square(coordinate) }.select do |square|
      player.does_not_own_piece_at_square?(square) || can_move_diagonal_by_en_passant?(square, player)
    end
  end

  def can_move_diagonal_by_en_passant?(square, player)
    if player.black?
      find_square(Coordinate.new(square.coordinate.x, square.coordinate.y + 1)).en_passant_capture_square? &&
      player.does_not_own_piece_at_square?(find_square(Coordinate.new(square.coordinate.x, square.coordinate.y + 1))) && @en_passant_squares.include?(en_passant_square(square, player))
    elsif player.white?
      find_square(Coordinate.new(square.coordinate.x, square.coordinate.y - 1)).en_passant_capture_square? && player.does_not_own_piece_at_square?(find_square(Coordinate.new(square.coordinate.x, square.coordinate.y - 1))) && @en_passant_squares.include?(en_passant_square(square, player))
    end
  end

  def en_passant_square(square, player)
    if player.black?
      find_square(Coordinate.new(square.coordinate.x, square.coordinate.y + 1)) if Coordinate.new(square.coordinate.x, square.coordinate.y + 1).valid?
    elsif player.white?
      find_square(Coordinate.new(square.coordinate.x, square.coordinate.y - 1)) if Coordinate.new(square.coordinate.x, square.coordinate.y - 1).valid?
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

  def can_castle_queenside?(player)
    return false if !find_king_square(player).unmoved? || !find_square(player.queenside_rook_coord).unmoved?

    [find_square(player.queenside_rook_coord.transform(1, 0)), find_square(player.queenside_rook_coord.transform(2, 0)), find_square(player.queenside_rook_coord.transform(3, 0))].all? do |square| 
      !square.occupied?
    end
  end

  def can_castle_kingside?(player)
    return false if !find_king_square(player).unmoved? || !find_square(player.kingside_rook_coord).unmoved?
    [find_square(player.kingside_rook_coord.transform(-1, 0))].all? do |square|
      !square.occupied?
    end
  end

  def castle_queenside(player)
    rook_coord = player.queenside_rook_coord
    king_coord = find_king_square(player).coordinate
    move_piece(rook_coord, rook_coord.transform(3, 0), player)
    move_piece(king_coord, king_coord.transform(-2, 0), player)
  end

  def castle_kingside(player)
    rook_coord = player.kingside_rook_coord
    king_coord = find_king_square(player).coordinate
    move_piece(rook_coord, rook_coord.transform(-2, 0), player)
    move_piece(king_coord, king_coord.transform(2, 0), player)
  end

  def valid_move_with_piece?(player, square, piece_square)
    !player.own_piece_at_square?(square) &&
      piece_square.piece_can_capture_forward?
  end

  def find_king_square(player)
    @squares.each do |row|
      row.each do |square|
        return square if player.own_piece_at_square?(square) && !square.piece_capturable?
      end
    end
  end

  def check?(player, opponent, kings_square = find_king_square(player))
    @squares.any? do |row|
      row.any? do |square|
        opponent.own_piece_at_square?(square) && reachable_squares(square.coordinate, opponent).include?(kings_square)
      end
    end
  end

  def valid_king_move?(coordinate, player, opponent)
    !check?(player, opponent, find_square(coordinate))
  end

  def color_king(player, opponent)
    if checkmate?(player, opponent)
      highlight_king(player, :red)
    elsif check?(player, opponent)
      highlight_king(player, :orange)
    else
      unhighlight_king(player)
    end
  end

  def highlight_king(player, color)
    find_king_square(player).highlight(color)
  end

  def unhighlight_king(player)
    find_king_square(player).remove_highlight
  end

  def checkmate?(player, opponent)
    check?(player, opponent) && no_way_out_of_check?(player, opponent)
  end

  def no_way_out_of_check?(player, opponent)
    @squares.all? do |row|
      row.all? do |square|
        player.does_not_own_piece_at_square?(square) || (player.own_piece_at_square?(square) && all_moves_result_in_check?(player, opponent, square))
      end
    end
  end

  def all_moves_result_in_check?(player, opponent, start_square)
    legal_moves(start_square.coordinate, player).all? { |end_square| move_results_in_check?(player, opponent, start_square, end_square) }
  end

  def move_results_in_check?(player, opponent, start_square, end_square)
    new_board = deep_dup
    new_board.move_piece(start_square.coordinate, end_square.coordinate)
    new_board.check?(player, opponent)
  end

  def stalemate?(player, opponent)
    !check?(player, opponent) && king_has_no_valid_moves?(player, opponent)
  end

  def king_has_no_valid_moves?(player, opponent)
    valid_move_squares = reachable_squares(find_king_square(player).coordinate, player, opponent)
    valid_move_squares.all? { |square| check?(player, opponent, square) }
  end

  def select_piece(coord, player)
    highlight_piece_and_moves(find_square(coord), legal_moves(coord, player))
  end

  def deselect_piece(coord, player)
    remove_square_highlights([find_square(coord)] + legal_moves(coord, player))
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
    @squares[coordinate.y][coordinate.x]
  end

  def queenside_castle_move?(start_coord, end_coord)
    !find_square(start_coord).piece_capturable? && end_coord == start_coord.transform(-2, 0)
  end

  def kingside_castle_move?(start_coord, end_coord)
    !find_square(start_coord).piece_capturable? && end_coord == start_coord.transform(2, 0)
  end

  def move_piece(start_coord, end_coord, player)
    start_square = find_square(start_coord)
    end_square = find_square(end_coord)
    end_square.place_piece(start_square.piece)
    start_square.remove_piece
    end_square.move_piece(start_coord, end_coord, player)
    end_square.promote_piece if end_square.piece_promotable?
    en_passant_square(end_square, player).remove_piece if @en_passant_squares.include?(en_passant_square(end_square, player))
    @en_passant_squares << end_square if end_square.en_passant_capture_square?
    @en_passant_squares = @en_passant_squares.select { |square| player.own_piece_at_square?(square) }
  end

  def valid_start_square?(coordinate, player)
    player.own_piece_at_square?(find_square(coordinate)) && !legal_moves(coordinate, player).empty?
  end

  private

  def make_row(y_coord)
    (0...Constants::BOARD_DIMENSION).to_a.map { |x_coord| Square.new(Coordinate.new(x_coord, y_coord)) }
  end
end
