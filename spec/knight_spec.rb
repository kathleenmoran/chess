# frozen_string_literal: true

require_relative '../lib/knight'
require_relative '../lib/coordinate'

describe Knight do
  subject(:black_knight) { described_class.new(:black) }
  subject(:white_knight) { described_class.new(:white) }

  let(:a8) { instance_double(Coordinate, x: 0, y: 7) }

  let(:b1) { instance_double(Coordinate, x: 1, y: 0) }
  let(:b3) { instance_double(Coordinate, x: 1, y: 2) }
  let(:b5) { instance_double(Coordinate, x: 1, y: 4) }
  let(:b6) { instance_double(Coordinate, x: 1, y: 5) }

  let(:c2) { instance_double(Coordinate, x: 2, y: 1) }
  let(:c6) { instance_double(Coordinate, x: 2, y: 5) }
  let(:c7) { instance_double(Coordinate, x: 2, y: 6) }

  let(:d4) { instance_double(Coordinate, x: 3, y: 3) }

  let(:e2) { instance_double(Coordinate, x: 4, y: 1) }
  let(:e6) { instance_double(Coordinate, x: 4, y: 5) }

  let(:f3) { instance_double(Coordinate, x: 5, y: 2) }
  let(:f5) { instance_double(Coordinate, x: 5, y: 4) }

  let(:invalid1) { instance_double(Coordinate, x: -2, y: 6) }
  let(:invalid2) { instance_double(Coordinate, x: -2, y: 8) }
  let(:invalid3) { instance_double(Coordinate, x: -1, y: 5) }
  let(:invalid4) { instance_double(Coordinate, x: -1, y: 9) }
  let(:invalid5) { instance_double(Coordinate, x: 1, y: 9) }
  let(:invalid6) { instance_double(Coordinate, x: 2, y: 8) }

  describe '#valid_moves' do
    context 'when the starting coordinate is D4' do
      before do
        allow(d4).to receive(:transform).and_return(b3, b5, c2, c6, e2, e6, f3, f5)
        allow(b3).to receive(:valid?).and_return(true)
        allow(b5).to receive(:valid?).and_return(true)
        allow(c2).to receive(:valid?).and_return(true)
        allow(c6).to receive(:valid?).and_return(true)
        allow(e2).to receive(:valid?).and_return(true)
        allow(e6).to receive(:valid?).and_return(true)
        allow(f3).to receive(:valid?).and_return(true)
        allow(f5).to receive(:valid?).and_return(true)
      end

      it 'returns an array with all the moves a knight can make from D4' do
        expect(black_knight.valid_moves(d4)).to contain_exactly([b3], [b5], [c2], [c6], [e2], [e6], [f3], [f5])
      end
    end

    context 'when the starting coordinate is A8' do
      before do
        allow(a8).to receive(:transform).and_return(invalid1, invalid2, invalid3, invalid4, b6, invalid5, c7, invalid6)
        allow(invalid1).to receive(:valid?).and_return(false)
        allow(invalid2).to receive(:valid?).and_return(false)
        allow(invalid3).to receive(:valid?).and_return(false)
        allow(invalid4).to receive(:valid?).and_return(false)
        allow(b6).to receive(:valid?).and_return(true)
        allow(invalid5).to receive(:valid?).and_return(false)
        allow(c7).to receive(:valid?).and_return(true)
        allow(invalid6).to receive(:valid?).and_return(false)
      end

      it 'returns an array with all the moves a knight can make from A8' do
        expect(black_knight.valid_moves(a8)).to contain_exactly([b6], [c7])
      end
    end
  end

  describe '#handles?' do
    context 'when the given coordinate is one of the coordinates that starts with a knight' do
      before do
        allow(b1).to receive(:in?).and_return(true)
      end

      it 'handles' do
        expect(described_class.handles?(b1)).to eq(true)
      end
    end

    context 'when the given coordinate is not one of the coordinates that starts with a knight' do
      before do
        allow(a8).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(a8)).to eq(false)
      end
    end
  end

  describe '#valid_captures' do
    it 'returns an empty array' do
      expect(black_knight.valid_captures(a8)).to be_empty
    end
  end

  describe '#valid_en_passant_capture' do
    it 'returns nil' do
      expect(black_knight.valid_en_passant_capture(a8)).to be_nil
    end
  end

  describe '#occupant?' do
    it 'is an occupant' do
      expect(black_knight).to be_occupant
    end
  end

  describe '#handles_promotion?' do
    context "when the given string is 'knight'" do
      it 'does handle the promotion' do
        expect(described_class.handles_promotion?('knight')).to eq(true)
      end
    end

    context "when the given string is not 'knight'" do
      it 'does not handle the promotion' do
        expect(described_class.handles_promotion?('queen')).to eq(false)
      end
    end
  end

  describe '#deep_dup' do
    context 'when the knight being duplicated is black' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(black_knight.instance_variable_get(:@color))
        black_knight.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(black_knight.deep_dup).not_to eq(black_knight)
      end

      it 'returns a knight' do
        expect(black_knight.deep_dup).to be_kind_of(described_class)
      end

      it 'is black' do
        expect(black_knight.deep_dup.instance_variable_get(:@color)).to eq(:black)
      end
    end

    context 'when the knight being duplicated is white' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(white_knight.instance_variable_get(:@color))
        white_knight.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(white_knight.deep_dup).not_to eq(white_knight)
      end

      it 'returns a knight' do
        expect(white_knight.deep_dup).to be_kind_of(described_class)
      end

      it 'is white' do
        expect(white_knight.deep_dup.instance_variable_get(:@color)).to eq(:white)
      end
    end
  end

  describe '#capturable?' do
    it 'is capturable' do
      expect(white_knight).to be_capturable
    end
  end

  describe '#king?' do
    it 'is not a king' do
      expect(white_knight).not_to be_king
    end
  end

  describe '#kingside_castle_move' do
    it 'returns nil' do
      expect(white_knight.kingside_castle_move(a8)).to be_nil
    end
  end

  describe '#queenside_castle_move' do
    it 'returns nil' do
      expect(white_knight.queenside_castle_move(a8)).to be_nil
    end
  end

  describe '#unmoved?' do
    it 'is not unmoved' do
      expect(white_knight).not_to be_unmoved
    end
  end

  describe '#can_en_passant?' do
    it 'cannot en passant' do
      expect(white_knight).not_to be_can_en_passant
    end
  end

  describe '#promotable?' do
    it 'cannot be promoted' do
      expect(white_knight).not_to be_promotable
    end
  end

  describe '#capturable_by_en_passant?' do
    it 'cannot be captured by en passant' do
      expect(white_knight).not_to be_capturable_by_en_passant
    end
  end

  describe '#can_capture_forward?' do
    it 'can capture forward' do
      expect(white_knight).to be_can_capture_forward
    end
  end
end
