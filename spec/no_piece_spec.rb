# frozen_string_literal: true

require_relative '../lib/no_piece'
require_relative '../lib/coordinate'

describe NoPiece do
  subject(:no_piece) { described_class.new(nil) }
  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }

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
        allow(a1).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(a1)).to eq(false)
      end
    end
  end

  describe '#valid_moves' do
    it 'returns an empty array' do
      expect(no_piece.valid_moves(d3)).to be_empty
    end
  end

  describe '#valid_captures' do
    it 'returns an empty array' do
      expect(no_piece.valid_captures(d3)).to be_empty
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

  describe '#handles_promotion?' do
    context 'when given any string' do
      it 'does not handle the promotion' do
        expect(described_class.handles_promotion?('knight')).to eq(false)
      end
    end
  end

  describe '#deep_dup' do
    it 'calls new on the described class' do
      expect(described_class)
        .to receive(:new)
        .with(no_piece.instance_variable_get(:@color))
      no_piece.deep_dup
    end

    it 'returns an object that is not equal to the original' do
      expect(no_piece.deep_dup).not_to eq(no_piece)
    end

    it 'returns a no piece' do
      expect(no_piece.deep_dup).to be_kind_of(described_class)
    end

    it 'is has a color that is nil' do
      expect(no_piece.deep_dup.instance_variable_get(:@color)).to be_nil
    end
  end

  describe '#capturable?' do
    it 'is capturable' do
      expect(no_piece).to be_capturable
    end
  end

  describe '#king?' do
    it 'is not a king' do
      expect(no_piece).not_to be_king
    end
  end

  describe '#kingside_castle_move' do
    it 'returns nil' do
      expect(no_piece.kingside_castle_move(a1)).to be_nil
    end
  end

  describe '#queenside_castle_move' do
    it 'returns nil' do
      expect(no_piece.queenside_castle_move(a1)).to be_nil
    end
  end

  describe '#unmoved?' do
    it 'is not unmoved' do
      expect(no_piece).not_to be_unmoved
    end
  end
end