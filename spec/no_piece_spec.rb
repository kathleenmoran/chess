# frozen_string_literal: true

require_relative '../lib/no_piece'
require_relative '../lib/coordinate'

describe NoPiece do
  subject(:no_piece) { described_class.new(nil) }
  let(:a0) { instance_double(Coordinate, x: 0, y: 0) }

  let(:d3) { instance_double(Coordinate, x: 3, y: 3) }

  describe '#handles?' do
    context 'when the given coordinate is one of the coordinates that starts without a piece' do
      before do
        allow(d3).to receive(:in?).and_return(true)
      end

      it 'handles' do
        expect(described_class.handles?(d3)).to eq(true)
      end
    end

    context 'when the given coordinate is not one of the coordinates that starts with a piece' do
      before do
        allow(a0).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(a0)).to eq(false)
      end
    end
  end

  describe '#valid_moves' do
    it 'returns nil' do
      expect(no_piece.valid_moves(d3)).to be_nil
    end
  end

  describe '#valid_captures' do
    it 'returns nil' do
      expect(no_piece.valid_captures(d3)).to be_nil
    end
  end

  describe '#valid_en_passant_capture' do
    it 'returns nil' do
      expect(no_piece.valid_en_passant_capture(d3)).to be_nil
    end
  end

  describe '#occupant?' do
    it 'is an occupant' do
      expect(no_piece).not_to be_occupant
    end
  end
end