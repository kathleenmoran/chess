# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/square'
require_relative '../lib/piece'

describe Player do
  subject(:black_player) { described_class.new(:black) }
  subject(:white_player) { described_class.new(:white) }

  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }
  let(:a2) { instance_double(Coordinate, x: 0, y: 2) }
  let(:a8) { instance_double(Coordinate, x: 0, y: 7) }

  let(:b1) { instance_double(Coordinate, x: 1, y: 0) }
  let(:b8) { instance_double(Coordinate, x: 1, y: 7) }

  let(:c1) { instance_double(Coordinate, x: 2, y: 0) }
  let(:c8) { instance_double(Coordinate, x: 2, y: 7) }

  let(:d1) { instance_double(Coordinate, x: 3, y: 0) }
  let(:d8) { instance_double(Coordinate, x: 3, y: 7) }

  let(:f1) { instance_double(Coordinate, x: 5, y: 0) }
  let(:f8) { instance_double(Coordinate, x: 5, y: 7) }

  let(:g1) { instance_double(Coordinate, x: 6, y: 0) }
  let(:g8) { instance_double(Coordinate, x: 6, y: 7) }

  let(:h1) { instance_double(Coordinate, x: 7, y: 0) }
  let(:h8) { instance_double(Coordinate, x: 7, y: 7) }

  let(:black_pawn) { instance_double(Piece, color: :black) }
  let(:white_pawn) { instance_double(Piece, color: :white) }

  let(:square_with_black_piece) { instance_double(Square, coordinate: a2, piece: black_pawn) }
  let(:square_with_white_piece) { instance_double(Square, coordinate: a2, piece: white_pawn) }

  describe '#own_piece_at_square?' do

    context 'when the colors of the player and piece at the given square are both black' do
      before do
        allow(square_with_black_piece).to receive(:occupied_by_black?).and_return(true)
      end

      it 'owns the piece at the square' do
        expect(black_player).to be_own_piece_at_square(square_with_black_piece)
      end
    end

    context 'when the colors of the player and piece at the given square are both white' do
      before do
        allow(square_with_white_piece).to receive(:occupied_by_white?).and_return(true)
      end

      it 'owns the piece at the square' do
        expect(white_player).to be_own_piece_at_square(square_with_white_piece)
      end
    end

    context 'when the colors of the player and piece at the given square are different' do
      before do
        allow(square_with_black_piece).to receive(:occupied_by_white?).and_return(false)
      end

      it 'does not own the piece at the square' do
        expect(white_player).not_to be_own_piece_at_square(square_with_black_piece)
      end
    end
  end

  describe '#does_not_own_piece_at_square?' do

    context 'when the colors of the player and piece at the given square are both black' do
      before do
        allow(square_with_black_piece).to receive(:occupied_by_white?).and_return(false)
      end

      it 'owns the piece at the square' do
        expect(black_player).not_to be_does_not_own_piece_at_square(square_with_black_piece)
      end
    end

    context 'when the colors of the player and piece at the given square are both white' do
      before do
        allow(square_with_white_piece).to receive(:occupied_by_black?).and_return(false)
      end

      it 'owns the piece at the square' do
        expect(white_player).not_to be_does_not_own_piece_at_square(square_with_white_piece)
      end
    end

    context 'when the colors of the player and piece at the given square are different' do
      before do
        allow(square_with_black_piece).to receive(:occupied_by_black?).and_return(true)
      end

      it 'does not own the piece at the square' do
        expect(white_player).to be_does_not_own_piece_at_square(square_with_black_piece)
      end
    end
  end

  describe '#select_start_square' do
    it 'calls select square with the opponent as a parameter' do
      expect(black_player).to receive(:select_square).with(white_player)
      black_player.select_start_square(white_player)
    end
  end

  describe '#select_end_square' do
    it 'calls select square with the opponent as a parameter' do
      expect(black_player).to receive(:select_square).with(white_player)
      black_player.select_end_square(white_player)
    end
  end

  describe '#queenside_rook_coord' do
    context 'when the player is white' do
      it 'returns a coordinate with an x of 0 and a y of 0' do
        expect(white_player.queenside_rook_coord).to eql(a1)
      end
    end

    context 'when the player is black' do
      it 'returns a coordinate with an x of 7 and a y of 0' do
        expect(black_player.queenside_rook_coord).to eql(a8)
      end
    end
  end

  describe '#kingside_rook_coord' do
    context 'when the player is white' do
      it 'returns a coordinate with an x of 0 and a y of 0' do
        expect(white_player.kingside_rook_coord).to eql(h1)
      end
    end

    context 'when the player is black' do
      it 'returns a coordinate with an x of 7 and a y of 0' do
        expect(black_player.kingside_rook_coord).to eql(h8)
      end
    end
  end

  describe '#queenside_castle_path' do
    context 'when the player is white' do
      it 'returns the queenside path in the bottom row' do
        expect(white_player.queenside_castle_path).to eql([d1, c1, b1])
      end
    end

    context 'when the player is black' do
      it 'returns the queenside path in the top row' do
        expect(black_player.queenside_castle_path).to eql([d8, c8, b8])
      end
    end
  end

  describe '#kingside_castle_path' do
    context 'when the player is white' do
      it 'returns the queenside path in the bottom row' do
        expect(white_player.kingside_castle_path).to eql([f1, g1])
      end
    end

    context 'when the player is black' do
      it 'returns the queenside path in the top row' do
        expect(black_player.kingside_castle_path).to eql([f8, g8])
      end
    end
  end
end