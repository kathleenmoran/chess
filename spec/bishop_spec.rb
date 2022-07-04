# frozen_string_literal: true

require_relative '../lib/bishop'
require_relative '../lib/coordinate'

describe Bishop do
  subject(:black_bishop) { described_class.new(:black) }
  subject(:white_bishop) { described_class.new(:white) }

  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }
  let(:a7) { instance_double(Coordinate, x: 0, y: 6) }
  let(:a8) { instance_double(Coordinate, x: 0, y: 7) }

  let(:b2) { instance_double(Coordinate, x: 1, y: 1) }
  let(:b6) { instance_double(Coordinate, x: 1, y: 5) }
  let(:b7) { instance_double(Coordinate, x: 1, y: 6) }
  let(:b8) { instance_double(Coordinate, x: 1, y: 7) }

  let(:c2) { instance_double(Coordinate, x: 2, y: 1) }
  let(:c3) { instance_double(Coordinate, x: 2, y: 2) }
  let(:c5) { instance_double(Coordinate, x: 2, y: 4) }
  let(:c6) { instance_double(Coordinate, x: 2, y: 5) }
  let(:c8) { instance_double(Coordinate, x: 2, y: 7) }

  let(:d4) { instance_double(Coordinate, x: 3, y: 3) }
  let(:d5) { instance_double(Coordinate, x: 3, y: 5) }

  let(:e3) { instance_double(Coordinate, x: 4, y: 2) }
  let(:e4) { instance_double(Coordinate, x: 4, y: 3) }
  let(:e5) { instance_double(Coordinate, x: 4, y: 4) }

  let(:f1) { instance_double(Coordinate, x: 5, y: 0) }
  let(:f2) { instance_double(Coordinate, x: 5, y: 1) }
  let(:f3) { instance_double(Coordinate, x: 5, y: 2) }
  let(:f6) { instance_double(Coordinate, x: 5, y: 5) }

  let(:g1) { instance_double(Coordinate, x: 6, y: 0) }
  let(:g2) { instance_double(Coordinate, x: 6, y: 1) }
  let(:g7) { instance_double(Coordinate, x: 6, y: 6) }

  let(:h1) { instance_double(Coordinate, x: 7, y: 0) }
  let(:h3) { instance_double(Coordinate, x: 7, y: 2) }
  let(:h8) { instance_double(Coordinate, x: 7, y: 7) }

  let(:invalid1) { instance_double(Coordinate, x: 7, y: -1) }
  let(:invalid2) { instance_double(Coordinate, x: 2, y: 8) }
  let(:invalid3) { instance_double(Coordinate, x: 3, y: 9) }
  let(:invalid4) { instance_double(Coordinate, x: 4, y: 10) }
  let(:invalid5) { instance_double(Coordinate, x: 5, y: 11) }
  let(:invalid6) { instance_double(Coordinate, x: 6, y: 12) }
  let(:invalid7) { instance_double(Coordinate, x: 7, y: 13) }
  let(:invalid8) { instance_double(Coordinate, x: 8, y: 3) }
  let(:invalid9) { instance_double(Coordinate, x: 9, y: 4) }
  let(:invalid10) { instance_double(Coordinate, x: 10, y: 5) }
  let(:invalid11) { instance_double(Coordinate, x: 11, y: 6) }
  let(:invalid12) { instance_double(Coordinate, x: 12, y: 7) }

  describe '#valid_moves' do
    context 'when the start coordinate is D4' do
      before do
        allow(d4).to receive(:min_coordinate).and_return(3)
        allow(d4).to receive(:transform).and_return(
          a1, b2, c3, d4, e5, f6, g7, h8, a7, b6, c5, d4, e3, f2, g1, invalid1
        )
        allow(a1).to receive(:valid?).and_return(true)
        allow(a1).to receive(:past_x?).and_return(false)
        allow(b2).to receive(:valid?).and_return(true)
        allow(b2).to receive(:past_x?).and_return(false)
        allow(c3).to receive(:valid?).and_return(true)
        allow(c3).to receive(:past_x?).and_return(false)
        allow(d4).to receive(:valid?).and_return(true, true)
        allow(d4).to receive(:past_x?).and_return(false)
        allow(d4).to receive(:past_y?).and_return(false)
        allow(e5).to receive(:valid?).and_return(true)
        allow(e5).to receive(:past_x?).and_return(true)
        allow(f6).to receive(:valid?).and_return(true)
        allow(f6).to receive(:past_x?).and_return(true)
        allow(g7).to receive(:valid?).and_return(true)
        allow(g7).to receive(:past_x?).and_return(true)
        allow(h8).to receive(:valid?).and_return(true)
        allow(h8).to receive(:past_x?).and_return(true)
        allow(a7).to receive(:valid?).and_return(true)
        allow(a7).to receive(:past_y?).and_return(true)
        allow(b6).to receive(:valid?).and_return(true)
        allow(b6).to receive(:past_y?).and_return(true)
        allow(c5).to receive(:valid?).and_return(true)
        allow(c5).to receive(:past_y?).and_return(true)
        allow(e3).to receive(:valid?).and_return(true)
        allow(e3).to receive(:past_y?).and_return(false)
        allow(f2).to receive(:valid?).and_return(true)
        allow(f2).to receive(:past_y?).and_return(false)
        allow(g1).to receive(:valid?).and_return(true)
        allow(g1).to receive(:past_y?).and_return(false)
        allow(invalid1).to receive(:valid?).and_return(false)
      end

      it 'returns an array with all the moves a diagonal piece can make from D4' do
        expect(black_bishop.valid_moves(d4)).to contain_exactly([c3, b2, a1], [e5, f6, g7, h8], [c5, b6, a7], [e3, f2, g1])
      end
    end

    context 'when the start coordinate is A7' do
      before do
        allow(a7).to receive(:min_coordinate).and_return(0)
        allow(a7).to receive(:transform).and_return(
          a7, b8, invalid2, invalid3, invalid4, invalid5, invalid6, invalid7, a7, b6, c5, d4, e3, f2, g1, invalid1
        )
        allow(a7).to receive(:valid?).and_return(true, true)
        allow(a7).to receive(:past_x?).and_return(false)
        allow(a7).to receive(:past_y?).and_return(false)
        allow(b8).to receive(:valid?).and_return(true)
        allow(b8).to receive(:past_x?).and_return(true)
        allow(invalid2).to receive(:valid?).and_return(false)
        allow(invalid3).to receive(:valid?).and_return(false)
        allow(invalid4).to receive(:valid?).and_return(false)
        allow(invalid5).to receive(:valid?).and_return(false)
        allow(invalid6).to receive(:valid?).and_return(false)
        allow(invalid7).to receive(:valid?).and_return(false)
        allow(b6).to receive(:valid?).and_return(true)
        allow(b6).to receive(:past_y?).and_return(false)
        allow(c5).to receive(:valid?).and_return(true)
        allow(c5).to receive(:past_y?).and_return(false)
        allow(d4).to receive(:valid?).and_return(true)
        allow(d4).to receive(:past_y?).and_return(false)
        allow(e3).to receive(:valid?).and_return(true)
        allow(e3).to receive(:past_y?).and_return(false)
        allow(f2).to receive(:valid?).and_return(true)
        allow(f2).to receive(:past_y?).and_return(false)
        allow(g1).to receive(:valid?).and_return(true)
        allow(g1).to receive(:past_y?).and_return(false)
        allow(invalid1).to receive(:valid?).and_return(false)
      end

      it 'returns an array with all the moves a diagonal piece can make from A7' do
        expect(black_bishop.valid_moves(a7)).to contain_exactly([], [b8], [b6, c5, d4, e3, f2, g1], [])
      end
    end

    context 'when the start coordinate is G2' do
      before do
        allow(g2).to receive(:min_coordinate).and_return(1)
        allow(g2).to receive(:transform).and_return(
          f1, g2, h3, invalid8, invalid9, invalid10, invalid11, invalid12, a8, b7, c6, d5, e4, f3, g2, h1
        )
        allow(f1).to receive(:valid?).and_return(true)
        allow(f1).to receive(:past_x?).and_return(false)
        allow(g2).to receive(:valid?).and_return(true, true)
        allow(g2).to receive(:past_x?).and_return(false)
        allow(g2).to receive(:past_y?).and_return(false)
        allow(h3).to receive(:valid?).and_return(true)
        allow(h3).to receive(:past_x?).and_return(true)
        allow(invalid8).to receive(:valid?).and_return(false)
        allow(invalid9).to receive(:valid?).and_return(false)
        allow(invalid10).to receive(:valid?).and_return(false)
        allow(invalid11).to receive(:valid?).and_return(false)
        allow(invalid12).to receive(:valid?).and_return(false)
        allow(a8).to receive(:valid?).and_return(true)
        allow(a8).to receive(:past_y?).and_return(true)
        allow(b7).to receive(:valid?).and_return(true)
        allow(b7).to receive(:past_y?).and_return(true)
        allow(c6).to receive(:valid?).and_return(true)
        allow(c6).to receive(:past_y?).and_return(true)
        allow(d5).to receive(:valid?).and_return(true)
        allow(d5).to receive(:past_y?).and_return(true)
        allow(e4).to receive(:valid?).and_return(true)
        allow(e4).to receive(:past_y?).and_return(true)
        allow(f3).to receive(:valid?).and_return(true)
        allow(f3).to receive(:past_y?).and_return(true)
        allow(h1).to receive(:valid?).and_return(true)
        allow(h1).to receive(:past_y?).and_return(false)
      end

      it 'returns an array with all the moves a diagonal piece can make from G2' do
        expect(black_bishop.valid_moves(g2)).to contain_exactly([f1], [h3], [h1], [f3, e4, d5, c6, b7, a8])
      end
    end
  end

  describe '#handles?' do
    context 'when the given coordinate is one of the coordinates that starts with a bishop' do
      before do
        allow(c2).to receive(:in?).and_return(true)
      end

      it 'handles' do
        expect(described_class.handles?(c2)).to eq(true)
      end
    end

    context 'when the given coordinate is not one of the coordinates that starts with a bishop' do
      before do
        allow(f2).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(f2)).to eq(false)
      end
    end
  end

  describe '#valid_captures' do
    it 'returns an empty array' do
      expect(black_bishop.valid_captures(f2)).to be_empty
    end
  end

  describe '#valid_en_passant_capture' do
    it 'returns nil' do
      expect(black_bishop.valid_en_passant_capture(f2)).to be_nil
    end
  end

  describe '#occupant?' do
    it 'is an occupant' do
      expect(black_bishop).to be_occupant
    end
  end

  describe '#handles_promotion?' do
    context "when the given string is 'bishop'" do
      it 'does handle the promotion' do
        expect(described_class.handles_promotion?('bishop')).to eq(true)
      end
    end

    context "when the given string is not 'bishop'" do
      it 'does not handle the promotion' do
        expect(described_class.handles_promotion?('queen')).to eq(false)
      end
    end
  end

  describe '#deep_dup' do
    context 'when the bishop being duplicated is black' do
      it 'calls new on the described class' do
        expect(described_class).to receive(:new).with(black_bishop.instance_variable_get(:@color))
        black_bishop.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(black_bishop.deep_dup).not_to eq(white_bishop)
      end

      it 'returns a bishop' do
        expect(black_bishop.deep_dup).to be_kind_of(described_class)
      end

      it 'is black' do
        expect(black_bishop.deep_dup.instance_variable_get(:@color)).to eq(:black)
      end
    end

    context 'when the bishop being duplicated is white' do
      it 'calls new on the described class' do
        expect(described_class).to receive(:new).with(white_bishop.instance_variable_get(:@color))
        white_bishop.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(white_bishop.deep_dup).not_to eq(white_bishop)
      end

      it 'returns a bishop' do
        expect(white_bishop.deep_dup).to be_kind_of(described_class)
      end

      it 'is white' do
        expect(white_bishop.deep_dup.instance_variable_get(:@color)).to eq(:white)
      end
    end
  end

  describe '#capturable?' do
    it 'is capturable' do
      expect(white_bishop).to be_capturable
    end
  end

  describe '#king?' do
    it 'is not a king' do
      expect(white_bishop).not_to be_king
    end
  end

  describe '#kingside_castle_move' do
    it 'returns nil' do
      expect(white_bishop.kingside_castle_move(a1)).to be_nil
    end
  end
end
