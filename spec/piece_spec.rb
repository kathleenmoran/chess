# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/coordinate'

describe Piece do
  subject(:black_piece) { described_class.new(:black) }
  subject(:white_piece) { described_class.new(:white) }
  
  let(:a2) { instance_double(Coordinate, x: 0, y: 1) }

  describe '#black?' do
    context 'when the piece has a black color' do
      it 'is black' do
        expect(black_piece).to be_black
      end
    end

    context 'when the piece does not have a black color' do
      it 'is not black' do
        expect(white_piece).not_to be_black
      end
    end
  end

  describe '#white?' do
    context 'when the piece has a white color' do
      it 'is white' do
        expect(white_piece).to be_white
      end
    end

    context 'when the piece does not have a black color' do
      it 'is not white' do
        expect(black_piece).not_to be_white
      end
    end
  end

  describe '#handles_promotion?' do
    context 'when given any string' do
      it 'does not handle the promotion' do
        expect(described_class.handles_promotion?('knight')).to eq(false)
      end
    end
  end

  describe '#capturable?' do
    it 'is capturable' do
      expect(white_piece).to be_capturable
    end
  end

  describe '#king?' do
    it 'is not a king' do
      expect(white_piece).not_to be_king
    end
  end

  describe '#kingside_castle_move' do
    it 'returns nil' do
      expect(white_piece.kingside_castle_move(a2)).to be_nil
    end
  end

  describe '#queenside_castle_move' do
    it 'returns nil' do
      expect(white_piece.queenside_castle_move(a2)).to be_nil
    end
  end

  describe '#unmoved?' do
    it 'is not unmoved' do
      expect(white_piece).not_to be_unmoved
    end
  end

  describe '#can_en_passant?' do
    it 'cannot en passant' do
      expect(white_piece).not_to be_can_en_passant
    end
  end
end
