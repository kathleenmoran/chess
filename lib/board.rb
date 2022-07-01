# frozen_string_literal: true

require_relative 'square'
require_relative 'constants'
require_relative 'coordinate'
require_relative 'player'
require_relative 'colorable'

# a chessboard
class Board
  include Colorable
  def initialize(squares = make_board, en_passant_square = nil)
    @squares = squares
    @en_passant_square = en_passant_square
  end

  def deep_dup
    Board.new(deep_dup_squares, deep_dup_en_passant)
  end

  def deep_dup_squares
    @squares.map do |row|
      row.map(&:deep_dup)
    end
  end

  def deep_dup_en_passant
    return if @en_passant_square.nil?

    @en_passant_square.deep_dup
  end

  def to_s
    string_board = @squares
                   .each_with_index
                   .map { |row, index| "#{index + 1} #{row.join}" }
                   .reverse
                   .join("\n")
    "\n#{string_board}\n   A  B  C  D  E  F  G  H\n\n"
  end

  def row_to_s(row)
    row.join
  end

  def valid_move?(start_coord, end_coord, player, opponent)
    player.own_piece_at_square?(find_square(start_coord)) &&
      legal_moves(start_coord, player, opponent).include?(find_square(end_coord))
  end

  def make_board
    (0...Constants::BOARD_DIMENSION).to_a.map { |y_coord| make_row(y_coord) }
  end

  def legal_moves(coord, player, opponent)
    reachable_squares(coord, player, opponent).select do |end_square|
      end_square.piece_capturable? && !move_results_in_check?(player, opponent, find_square(coord), end_square)
    end
  end

  def reachable_squares(coord, player, opponent)
    start_square = find_square(coord)
    normal_move_squares(start_square, player) +
      diagonal_capture_squares(start_square, player) +
      valid_king_castle_squares(start_square, player, opponent)
  end

  def valid_king_castle_squares(start_square, player, opponent)
    move_squares = []
    return move_squares unless start_square.occupied_by_king?

    move_squares << find_square(start_square.queenside_castle_piece_move) if can_castle_queenside?(player, opponent)
    move_squares << find_square(start_square.kingside_castle_piece_move) if can_castle_kingside?(player, opponent)

    move_squares
  end

  def normal_move_squares(start_square, player)
    start_square
      .valid_moves_of_piece
      .reduce([]) do |valid_end_squares, path|
        valid_end_squares + reachable_squares_in_a_path(path, player, start_square)
      end
  end

  def diagonal_capture_squares(start_square, player)
    start_square
      .valid_piece_captures
      .map { |coord| find_square(coord) }
      .select do |square|
        player.does_not_own_piece_at_square?(square) ||
          can_move_by_en_passant?(start_square, square, player)
      end
  end

  def can_move_by_en_passant?(start_square, end_square, player)
    en_passant_coord = end_square.piece_en_passant_coord(start_square)
    return false if !start_square.piece_can_en_passant? || en_passant_coord.nil?

    potential_en_passant_square = find_square(en_passant_coord)
    player.does_not_own_piece_at_square?(potential_en_passant_square) &&
      @en_passant_square == potential_en_passant_square
  end

  def can_castle?(player, opponent, path, rook_coord)
    king_square = find_king_square(player)
    return false if !king_square.unmoved? ||
                    !find_square(rook_coord).unmoved? ||
                    move_results_in_check?(player, opponent, king_square, find_square(path[0]))

    find_squares(path).all? { |square| !square.occupied? }
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

  def can_castle_queenside?(player, opponent)
    can_castle?(player, opponent, player.queenside_castle_path, player.queenside_rook_coord)
  end

  def can_castle_kingside?(player, opponent)
    can_castle?(player, opponent, player.kingside_castle_path, player.kingside_rook_coord)
  end

  def castle(player, rook_start_square, rook_end_square, king_start_square, king_end_square)
    make_normal_move(rook_start_square, rook_end_square, player)
    make_normal_move(king_start_square, king_end_square, player)
  end

  def castle_queenside(player)
    rook_start_square = find_square(player.queenside_rook_coord)
    rook_end_square = find_square(rook_start_square.queenside_castle_piece_move)
    king_start_square = find_king_square(player)
    king_end_square = find_square(king_start_square.queenside_castle_piece_move)
    castle(player, rook_start_square, rook_end_square, king_start_square, king_end_square)
  end

  def castle_kingside(player)
    rook_start_square = find_square(player.kingside_rook_coord)
    rook_end_square = find_square(rook_start_square.kingside_castle_piece_move)
    king_start_square = find_king_square(player)
    king_end_square = find_square(king_start_square.kingside_castle_piece_move)
    castle(player, rook_start_square, rook_end_square, king_start_square, king_end_square)
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
        opponent.own_piece_at_square?(square) &&
          reachable_squares(square.coordinate, opponent, player).include?(kings_square)
      end
    end
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

  def stalemate?(player, opponent)
    !check(player, opponent) && no_way_out_of_check?(player, opponent)
  end

  def no_way_out_of_check?(player, opponent)
    @squares.all? do |row|
      row.all? do |square|
        player.does_not_own_piece_at_square?(square) ||
          !square.occupied? ||
          (player.own_piece_at_square?(square) &&
          all_moves_result_in_check?(player, opponent, square))
      end
    end
  end

  def all_moves_result_in_check?(player, opponent, start_square)
    legal_moves(start_square.coordinate, player, opponent).all? do |end_square|
      move_results_in_check?(player, opponent, start_square, end_square)
    end
  end

  def move_results_in_check?(player, opponent, start_square, end_square)
    new_board = deep_dup
    new_board.update_with_move(start_square.coordinate, end_square.coordinate, player)
    new_board.check?(player, opponent)
  end

  def select_piece(coord, player, opponent)
    highlight_piece_and_moves(find_square(coord), legal_moves(coord, player, opponent))
  end

  def deselect_piece(coord, player, opponent)
    remove_square_highlights([find_square(coord)] + legal_moves(coord, player, opponent))
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
    return if coordinate.nil?

    @squares[coordinate.y][coordinate.x]
  end

  def queenside_castle_move?(start_coord, end_coord)
    find_square(start_coord).occupied_by_king? && end_coord == start_coord.transform(-2, 0)
  end

  def kingside_castle_move?(start_coord, end_coord)
    find_square(start_coord).occupied_by_king? && end_coord == start_coord.transform(2, 0)
  end

  def update_with_move(start_coord, end_coord, player)
    start_square = find_square(start_coord)
    end_square = find_square(end_coord)

    potential_en_passant_square = find_square(end_square.piece_en_passant_coord(start_square))
    @en_passant_square.remove_piece if !@en_passant_square.nil? && potential_en_passant_square == @en_passant_square

    make_move(start_square, end_square, player)

    update_en_passant_square(find_square(end_coord))

    end_square.promote_piece if end_square.piece_promotable?
  end

  def update_en_passant_square(end_square)
    @en_passant_square = end_square.en_passant_capture_square? ? end_square : nil
  end

  def make_normal_move(start_square, end_square, player)
    end_square.place_piece(start_square.piece)
    start_square.remove_piece
    end_square.move_piece(start_square.coordinate, end_square.coordinate, player)
  end

  def make_move(start_square, end_square, player)
    if queenside_castle_move?(start_square.coordinate, end_square.coordinate)
      castle_queenside(player)
    elsif kingside_castle_move?(start_square.coordinate, end_square.coordinate)
      castle_kingside(player)
    else
      make_normal_move(start_square, end_square, player)
    end
  end

  def valid_start_square?(coordinate, player, opponent)
    player.own_piece_at_square?(find_square(coordinate)) && !legal_moves(coordinate, player, opponent).empty?
  end

  private

  def make_row(y_coord)
    (0...Constants::BOARD_DIMENSION).to_a.map { |x_coord| Square.new(Coordinate.new(x_coord, y_coord)) }
  end
end
