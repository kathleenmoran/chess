# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/coordinate'
require_relative '../lib/square'
require_relative '../lib/player'

describe Board do
  subject(:start_board) { described_class.new }
  subject(:start_board_with_en_passant) { described_class.new(board_values, square_a2) }

  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }
  let(:a2) { instance_double(Coordinate, x: 0, y: 1) }
  let(:a3) { instance_double(Coordinate, x: 0, y: 2) }
  let(:a4) { instance_double(Coordinate, x: 0, y: 3) }
  let(:a5) { instance_double(Coordinate, x: 0, y: 4) }
  let(:a6) { instance_double(Coordinate, x: 0, y: 5) }
  let(:a7) { instance_double(Coordinate, x: 0, y: 6) }
  let(:a8) { instance_double(Coordinate, x: 0, y: 7) }

  let(:b1) { instance_double(Coordinate, x: 1, y: 0) }
  let(:b2) { instance_double(Coordinate, x: 1, y: 1) }
  let(:b3) { instance_double(Coordinate, x: 1, y: 2) }
  let(:b4) { instance_double(Coordinate, x: 1, y: 3) }
  let(:b5) { instance_double(Coordinate, x: 1, y: 4) }
  let(:b6) { instance_double(Coordinate, x: 1, y: 5) }
  let(:b7) { instance_double(Coordinate, x: 1, y: 6) }
  let(:b8) { instance_double(Coordinate, x: 1, y: 7) }

  let(:c1) { instance_double(Coordinate, x: 2, y: 0) }
  let(:c2) { instance_double(Coordinate, x: 2, y: 1) }
  let(:c3) { instance_double(Coordinate, x: 2, y: 2) }
  let(:c4) { instance_double(Coordinate, x: 2, y: 3) }
  let(:c5) { instance_double(Coordinate, x: 2, y: 4) }
  let(:c6) { instance_double(Coordinate, x: 2, y: 5) }
  let(:c7) { instance_double(Coordinate, x: 2, y: 6) }
  let(:c8) { instance_double(Coordinate, x: 2, y: 7) }

  let(:d1) { instance_double(Coordinate, x: 3, y: 0) }
  let(:d2) { instance_double(Coordinate, x: 3, y: 1) }
  let(:d3) { instance_double(Coordinate, x: 3, y: 2) }
  let(:d4) { instance_double(Coordinate, x: 3, y: 3) }
  let(:d5) { instance_double(Coordinate, x: 3, y: 4) }
  let(:d6) { instance_double(Coordinate, x: 3, y: 5) }
  let(:d7) { instance_double(Coordinate, x: 3, y: 6) }
  let(:d8) { instance_double(Coordinate, x: 3, y: 7) }

  let(:e1) { instance_double(Coordinate, x: 4, y: 0) }
  let(:e2) { instance_double(Coordinate, x: 4, y: 1) }
  let(:e3) { instance_double(Coordinate, x: 4, y: 2) }
  let(:e4) { instance_double(Coordinate, x: 4, y: 3) }
  let(:e5) { instance_double(Coordinate, x: 4, y: 4) }
  let(:e6) { instance_double(Coordinate, x: 4, y: 5) }
  let(:e7) { instance_double(Coordinate, x: 4, y: 6) }
  let(:e8) { instance_double(Coordinate, x: 4, y: 7) }

  let(:f1) { instance_double(Coordinate, x: 5, y: 0) }
  let(:f2) { instance_double(Coordinate, x: 5, y: 1) }
  let(:f3) { instance_double(Coordinate, x: 5, y: 2) }
  let(:f4) { instance_double(Coordinate, x: 5, y: 3) }
  let(:f5) { instance_double(Coordinate, x: 5, y: 4) }
  let(:f6) { instance_double(Coordinate, x: 5, y: 5) }
  let(:f7) { instance_double(Coordinate, x: 5, y: 6) }
  let(:f8) { instance_double(Coordinate, x: 5, y: 7) }

  let(:g1) { instance_double(Coordinate, x: 6, y: 0) }
  let(:g2) { instance_double(Coordinate, x: 6, y: 1) }
  let(:g3) { instance_double(Coordinate, x: 6, y: 2) }
  let(:g4) { instance_double(Coordinate, x: 6, y: 3) }
  let(:g5) { instance_double(Coordinate, x: 6, y: 4) }
  let(:g6) { instance_double(Coordinate, x: 6, y: 5) }
  let(:g7) { instance_double(Coordinate, x: 6, y: 6) }
  let(:g8) { instance_double(Coordinate, x: 6, y: 7) }

  let(:h1) { instance_double(Coordinate, x: 7, y: 0) }
  let(:h2) { instance_double(Coordinate, x: 7, y: 1) }
  let(:h3) { instance_double(Coordinate, x: 7, y: 2) }
  let(:h4) { instance_double(Coordinate, x: 7, y: 3) }
  let(:h5) { instance_double(Coordinate, x: 7, y: 4) }
  let(:h6) { instance_double(Coordinate, x: 7, y: 5) }
  let(:h7) { instance_double(Coordinate, x: 7, y: 6) }
  let(:h8) { instance_double(Coordinate, x: 7, y: 7) }

  let(:square_a1) { instance_double(Square, coordinate: a1) }
  let(:square_a2) { instance_double(Square, coordinate: a2) }
  let(:square_a3) { instance_double(Square, coordinate: a3) }
  let(:square_a4) { instance_double(Square, coordinate: a4) }
  let(:square_a5) { instance_double(Square, coordinate: a5) }
  let(:square_a6) { instance_double(Square, coordinate: a6) }
  let(:square_a7) { instance_double(Square, coordinate: a7) }
  let(:square_a8) { instance_double(Square, coordinate: a8) }

  let(:square_b1) { instance_double(Square, coordinate: b1) }
  let(:square_b2) { instance_double(Square, coordinate: b2) }
  let(:square_b3) { instance_double(Square, coordinate: b3) }
  let(:square_b4) { instance_double(Square, coordinate: b4) }
  let(:square_b5) { instance_double(Square, coordinate: b5) }
  let(:square_b6) { instance_double(Square, coordinate: b6) }
  let(:square_b7) { instance_double(Square, coordinate: b7) }
  let(:square_b8) { instance_double(Square, coordinate: b8) }

  let(:square_c1) { instance_double(Square, coordinate: c1) }
  let(:square_c2) { instance_double(Square, coordinate: c2) }
  let(:square_c3) { instance_double(Square, coordinate: c3) }
  let(:square_c4) { instance_double(Square, coordinate: c4) }
  let(:square_c5) { instance_double(Square, coordinate: c5) }
  let(:square_c6) { instance_double(Square, coordinate: c6) }
  let(:square_c7) { instance_double(Square, coordinate: c7) }
  let(:square_c8) { instance_double(Square, coordinate: c8) }

  let(:square_d1) { instance_double(Square, coordinate: d1) }
  let(:square_d2) { instance_double(Square, coordinate: d2) }
  let(:square_d3) { instance_double(Square, coordinate: d3) }
  let(:square_d4) { instance_double(Square, coordinate: d4) }
  let(:square_d5) { instance_double(Square, coordinate: d5) }
  let(:square_d6) { instance_double(Square, coordinate: d6) }
  let(:square_d7) { instance_double(Square, coordinate: d7) }
  let(:square_d8) { instance_double(Square, coordinate: d8) }

  let(:square_e1) { instance_double(Square, coordinate: e1) }
  let(:square_e2) { instance_double(Square, coordinate: e2) }
  let(:square_e3) { instance_double(Square, coordinate: e3) }
  let(:square_e4) { instance_double(Square, coordinate: e4) }
  let(:square_e5) { instance_double(Square, coordinate: e5) }
  let(:square_e6) { instance_double(Square, coordinate: e6) }
  let(:square_e7) { instance_double(Square, coordinate: e7) }
  let(:square_e8) { instance_double(Square, coordinate: e8) }

  let(:square_f1) { instance_double(Square, coordinate: f1) }
  let(:square_f2) { instance_double(Square, coordinate: f2) }
  let(:square_f3) { instance_double(Square, coordinate: f3) }
  let(:square_f4) { instance_double(Square, coordinate: f4) }
  let(:square_f5) { instance_double(Square, coordinate: f5) }
  let(:square_f6) { instance_double(Square, coordinate: f6) }
  let(:square_f7) { instance_double(Square, coordinate: f7) }
  let(:square_f8) { instance_double(Square, coordinate: f8) }

  let(:square_g1) { instance_double(Square, coordinate: g1) }
  let(:square_g2) { instance_double(Square, coordinate: g2) }
  let(:square_g3) { instance_double(Square, coordinate: g3) }
  let(:square_g4) { instance_double(Square, coordinate: g4) }
  let(:square_g5) { instance_double(Square, coordinate: g5) }
  let(:square_g6) { instance_double(Square, coordinate: g6) }
  let(:square_g7) { instance_double(Square, coordinate: g7) }
  let(:square_g8) { instance_double(Square, coordinate: g8) }

  let(:square_h1) { instance_double(Square, coordinate: h1) }
  let(:square_h2) { instance_double(Square, coordinate: h2) }
  let(:square_h3) { instance_double(Square, coordinate: h3) }
  let(:square_h4) { instance_double(Square, coordinate: h4) }
  let(:square_h5) { instance_double(Square, coordinate: h5) }
  let(:square_h6) { instance_double(Square, coordinate: h6) }
  let(:square_h7) { instance_double(Square, coordinate: h7) }
  let(:square_h8) { instance_double(Square, coordinate: h8) }

  let(:board_values) do
    [
      [square_a1, square_b1, square_c1, square_d1, square_e1, square_f1, square_g1, square_h1],
      [square_a2, square_b2, square_c2, square_d2, square_e2, square_f2, square_g2, square_h2],
      [square_a3, square_b3, square_c3, square_d3, square_e3, square_f3, square_g3, square_h3],
      [square_a4, square_b4, square_c4, square_d4, square_e4, square_f4, square_g4, square_h4],
      [square_a5, square_b5, square_c5, square_d5, square_e5, square_f5, square_g5, square_h5],
      [square_a6, square_b6, square_c6, square_d6, square_e6, square_f6, square_g6, square_h6],
      [square_a7, square_b7, square_c7, square_d7, square_e7, square_f7, square_g7, square_h7],
      [square_a8, square_b8, square_c8, square_d8, square_e8, square_f8, square_g8, square_h8]
    ]
  end

  let(:black_player) { instance_double(Player, color: :black) }
  let(:white_player) { instance_double(Player, color: :white) }

  describe '#select_piece' do
    before do
      allow(start_board).to receive(:find_square).and_return(square_a2)
      allow(start_board).to receive(:legal_moves).and_return([square_a3, square_a4])
      allow(start_board).to receive(:highlight_piece_and_moves)
    end

    it 'calls #highlight_piece_and_moves' do
      expect(start_board).to receive(:highlight_piece_and_moves)
      start_board.select_piece(a2, white_player, black_player)
    end

    it 'calls #find_square' do
      expect(start_board).to receive(:find_square).with(a2)
      start_board.select_piece(a2, white_player, black_player)
    end

    it 'calls legal moves' do
      expect(start_board).to receive(:legal_moves).with(a2, white_player, black_player)
      start_board.select_piece(a2, white_player, black_player)
    end
  end

  describe '#deselect_piece' do
    before do
      allow(start_board).to receive(:find_square).and_return(square_a2)
      allow(start_board).to receive(:legal_moves).and_return([square_a3, square_a4])
      allow(start_board).to receive(:remove_square_highlights)
    end

    it 'calls #remove_square_highlights' do
      expect(start_board).to receive(:remove_square_highlights)
      start_board.deselect_piece(a2, white_player, black_player)
    end

    it 'calls #find_square' do
      expect(start_board).to receive(:find_square).with(a2)
      start_board.deselect_piece(a2, white_player, black_player)
    end

    it 'calls legal moves' do
      expect(start_board).to receive(:legal_moves).with(a2, white_player, black_player)
      start_board.deselect_piece(a2, white_player, black_player)
    end
  end

  describe '#checkmate?' do
    context 'when the player is in check and there is no way out of the check' do
      before do
        allow(start_board).to receive(:check?).and_return(true)
        allow(start_board).to receive(:no_way_out_of_check?).and_return(true)
      end

      it 'is a checkmate' do
        expect(start_board).to be_checkmate(white_player, black_player)
      end
    end

    context 'when the player is in check and there is a way out of the check' do
      before do
        allow(start_board).to receive(:check?).and_return(true)
        allow(start_board).to receive(:no_way_out_of_check?).and_return(false)
      end

      it 'is not a checkmate' do
        expect(start_board).not_to be_checkmate(white_player, black_player)
      end
    end

    context 'when the player is not in check and there are no available moves' do
      before do
        allow(start_board).to receive(:check?).and_return(false)
      end

      it 'is not a checkmate' do
        expect(start_board).not_to be_checkmate(white_player, black_player)
      end
    end
  end

  describe '#stalemate?' do
    context 'when the player is not in check and there are no available moves' do
      before do
        allow(start_board).to receive(:check?).and_return(false)
        allow(start_board).to receive(:no_way_out_of_check?).and_return(true)
      end

      it 'is a checkmate' do
        expect(start_board).to be_stalemate(white_player, black_player)
      end
    end

    context 'when the player is not in check and there are no available moves' do
      before do
        allow(start_board).to receive(:check?).and_return(false)
        allow(start_board).to receive(:no_way_out_of_check?).and_return(false)
      end

      it 'is not a checkmate' do
        expect(start_board).not_to be_stalemate(white_player, black_player)
      end
    end

    context 'when the player is in check and there are no available moves' do
      before do
        allow(start_board).to receive(:check?).and_return(true)
      end

      it 'is not a checkmate' do
        expect(start_board).not_to be_stalemate(white_player, black_player)
      end
    end
  end

  describe '#valid_start_square?' do
    context 'when the player owns the piece at the square and there is at least one legal move' do
      before do
        allow(white_player).to receive(:own_piece_at_square?).and_return(true)
        allow(start_board).to receive(:legal_moves).and_return([square_a3, square_a4])
      end

      it 'is a valid start square' do
        expect(start_board).to be_valid_start_square(a2, white_player, black_player)
      end
    end

    context 'when the player owns the piece at the square but there are no legal moves' do
      before do
        allow(white_player).to receive(:own_piece_at_square?).and_return(true)
        allow(start_board).to receive(:legal_moves).and_return([])
      end

      it 'is not a valid start square' do
        expect(start_board).not_to be_valid_start_square(a2, white_player, black_player)
      end
    end

    context 'when the player does not own the piece at the square and there is at least one legal move' do
      before do
        allow(white_player).to receive(:own_piece_at_square?).and_return(false)
      end

      it 'is not a valid start square' do
        expect(start_board).not_to be_valid_start_square(a2, white_player, black_player)
      end
    end
  end

  describe '#color_king' do
    context 'when there is a checkmate' do
      before do
        allow(start_board).to receive(:checkmate?).and_return(true)
      end

      it 'will color the king square red' do
        expect(start_board).to receive(:highlight_king).with(white_player, :red)
        start_board.color_king(white_player, black_player)
      end
    end

    context 'when there is a check' do
      before do
        allow(start_board).to receive(:checkmate?).and_return(false)
        allow(start_board).to receive(:check?).and_return(true)
      end

      it 'will color the king square orange' do
        expect(start_board).to receive(:highlight_king).with(white_player, :orange)
        start_board.color_king(white_player, black_player)
      end
    end

    context 'when there is neither a checkmate nor a stalemate' do
      before do
        allow(start_board).to receive(:checkmate?).and_return(false)
        allow(start_board).to receive(:check?).and_return(false)
      end

      it 'will remove highlighting from the king square' do
        expect(start_board).to receive(:unhighlight_king).with(white_player)
        start_board.color_king(white_player, black_player)
      end
    end
  end

  describe '#valid_move?' do
    context 'when the player owns the piece at the start coordinate and the end coordinate '\
    "square is in the piece's legal moves" do
      before do
        allow(white_player).to receive(:own_piece_at_square?).and_return(true)
        allow(start_board).to receive(:find_square).and_return(square_a2, square_a3)
        allow(start_board).to receive(:legal_moves).and_return([square_a3, square_a4])
      end

      it 'is a valid move' do
        expect(start_board).to be_valid_move(a2, a3, white_player, black_player)
      end
    end

    context 'when the player owns the piece at the start coordinate but the end coordinate '\
    "square is not in the piece's legal moves" do
      before do
        allow(white_player).to receive(:own_piece_at_square?).and_return(true)
        allow(start_board).to receive(:find_square).and_return(square_a2, square_a4)
        allow(start_board).to receive(:legal_moves).and_return([square_a3])
      end

      it 'is not a valid move' do
        expect(start_board).not_to be_valid_move(a2, a4, white_player, black_player)
      end
    end

    context 'when the player does not own the piece at the start coordinate and the end coordinate '\
    "square is in the piece's legal moves" do
      before do
        allow(white_player).to receive(:own_piece_at_square?).and_return(false)
      end

      it 'is not a valid move' do
        expect(start_board).not_to be_valid_move(a2, a3, white_player, black_player)
      end
    end
  end

  describe '#check?' do
    context "when none of the opponent's pieces can reach the player's king" do
      before do
        allow(start_board).to receive(:find_king_square).and_return(square_e1)
        allow(black_player).to receive(:own_piece_at_square?).and_return(true)
        allow(start_board).to receive(:reachable_squares).and_return([square_e1])
      end

      it 'is a check' do
        expect(start_board).to be_check(white_player, black_player)
      end
    end

    context "when at least one of the opponent's piece can reach the player's king" do
      before do
        allow(start_board).to receive(:find_king_square).and_return(square_e1)
        allow(black_player).to receive(:own_piece_at_square?).and_return(true)
        allow(start_board).to receive(:reachable_squares).and_return([])
      end

      it 'is not a check' do
        expect(start_board).not_to be_check(white_player, black_player)
      end
    end
  end

  describe '#update_with_move' do
    context 'when the player makes a move that does not result in a promotion or an en passant capture' do
      before do
        allow(start_board).to receive(:find_square).and_return(square_a2, square_a3, square_a2)
        allow(square_a3).to receive(:piece_en_passant_coord)
        allow(start_board).to receive(:update_en_passant_square)
        allow(start_board).to receive(:make_move)
        allow(square_a3).to receive(:piece_promotable?).and_return(false)
      end

      it 'calls make move with the player, start square, and end square' do
        expect(start_board).to receive(:make_move).with(square_a2, square_a3, white_player)
        start_board.update_with_move(a2, a3, white_player)
      end

      it 'does not remove the piece at the en passant square' do
        expect(start_board.instance_variable_get(:@en_passant_square)).not_to receive(:remove_piece)
        start_board.update_with_move(a2, a3, white_player)
      end

      it 'does not promote the piece at the end square' do
        expect(square_a3).not_to receive(:promote_piece)
        start_board.update_with_move(a2, a3, white_player)
      end
    end

    context 'when the player makes a move that results in a promotion' do
      before do
        allow(start_board).to receive(:find_square).and_return(square_a2, square_a3, square_a2)
        allow(square_a3).to receive(:piece_en_passant_coord)
        allow(start_board).to receive(:update_en_passant_square)
        allow(start_board).to receive(:make_move)
        allow(square_a3).to receive(:piece_promotable?).and_return(true)
        allow(square_a3).to receive(:promote_piece)
      end

      it 'calls make move with the player, start square, and end square' do
        expect(start_board).to receive(:make_move).with(square_a2, square_a3, white_player)
        start_board.update_with_move(a2, a3, white_player)
      end

      it 'does not remove the piece at the en passant square' do
        expect(start_board.instance_variable_get(:@en_passant_square)).not_to receive(:remove_piece)
        start_board.update_with_move(a2, a3, white_player)
      end

      it 'does not promote the piece at the end square' do
        expect(square_a3).to receive(:promote_piece)
        start_board.update_with_move(a2, a3, white_player)
      end
    end

    context 'when the player makes a move that results in an en passant capture' do
      before do
        allow(start_board_with_en_passant).to receive(:find_square).and_return(square_a2, square_a3, square_a2)
        allow(square_a3).to receive(:piece_en_passant_coord)
        allow(start_board_with_en_passant).to receive(:update_en_passant_square)
        allow(start_board_with_en_passant).to receive(:make_move)
        allow(square_a3).to receive(:piece_promotable?).and_return(false)
        allow(square_a2).to receive(:remove_piece)
      end

      it 'calls make move with the player, start square, and end square' do
        expect(start_board_with_en_passant).to receive(:make_move).with(square_a2, square_a3, white_player)
        start_board_with_en_passant.update_with_move(a2, a3, white_player)
      end

      it 'does not remove the piece at the en passant square' do
        expect(start_board_with_en_passant.instance_variable_get(:@en_passant_square)).to receive(:remove_piece)
        start_board_with_en_passant.update_with_move(a2, a3, white_player)
      end

      it 'does not promote the piece at the end square' do
        expect(square_a3).not_to receive(:promote_piece)
        start_board_with_en_passant.update_with_move(a2, a3, white_player)
      end
    end
  end
end
