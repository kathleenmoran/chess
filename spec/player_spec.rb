# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/square'
require_relative '../lib/piece'

describe Player do
  subject(:black_player) { described_class.new(:black) }
  subject(:white_player) { described_class.new(:white) }

  let(:a2) { instance_double(Coordinate, x: 0, y: 2) }

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
end