# frozen_string_literal: true

require_relative '../lib/queen'
require_relative '../lib/coordinate'

describe Queen do
  subject(:queen) { described_class.new(:black) }

  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }
  let(:a4) { instance_double(Coordinate, x: 0, y: 3) }
  let(:a7) { instance_double(Coordinate, x: 0, y: 6) }

  let(:b2) { instance_double(Coordinate, x: 1, y: 1) }
  let(:b4) { instance_double(Coordinate, x: 1, y: 3) }
  let(:b6) { instance_double(Coordinate, x: 1, y: 5) }

  let(:c3) { instance_double(Coordinate, x: 2, y: 2) }
  let(:c4) { instance_double(Coordinate, x: 2, y: 3) }
  let(:c5) { instance_double(Coordinate, x: 2, y: 4) }

  let(:d1) { instance_double(Coordinate, x: 3, y: 0) }
  let(:d2) { instance_double(Coordinate, x: 3, y: 1) }
  let(:d3) { instance_double(Coordinate, x: 3, y: 2) }
  let(:d4) { instance_double(Coordinate, x: 3, y: 3) }
  let(:d5) { instance_double(Coordinate, x: 3, y: 4) }
  let(:d6) { instance_double(Coordinate, x: 3, y: 5) }
  let(:d7) { instance_double(Coordinate, x: 3, y: 6) }
  let(:d8) { instance_double(Coordinate, x: 3, y: 7) }

  let(:e3) { instance_double(Coordinate, x: 4, y: 2) }
  let(:e4) { instance_double(Coordinate, x: 4, y: 3) }
  let(:e5) { instance_double(Coordinate, x: 4, y: 4) }

  let(:f2) { instance_double(Coordinate, x: 5, y: 1) }
  let(:f4) { instance_double(Coordinate, x: 5, y: 3) }
  let(:f6) { instance_double(Coordinate, x: 5, y: 5) }

  let(:g1) { instance_double(Coordinate, x: 6, y: 0) }
  let(:g4) { instance_double(Coordinate, x: 6, y: 3) }
  let(:g7) { instance_double(Coordinate, x: 6, y: 6) }

  let(:h4) { instance_double(Coordinate, x: 7, y: 3) }
  let(:h8) { instance_double(Coordinate, x: 7, y: 7) }

  let(:invalid1) { instance_double(Coordinate, x: 7, y: -1) }

  context 'when the starting position is D4' do
    before do
      allow(d4).to receive(:min_coordinate).and_return(3)
      allow(d4).to receive(:transform).and_return(
        a1, b2, c3, d4, e5, f6, g7, h8, a7, b6, c5, d4, e3, f2, g1, invalid1,
        d5, d6, d7, d8, d1, d2, d3, a4, b4, c4, e4, f4, g4, h4
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

    it 'returns all the valid moves for a queen at position D4' do
      expect(queen.valid_moves(d4)).to contain_exactly(
        [c3, b2, a1], [e5, f6, g7, h8], [c5, b6, a7], [e3, f2, g1],
        [d5, d6, d7, d8], [d3, d2, d1], [c4, b4, a4], [e4, f4, g4, h4]
      )
    end
  end

  describe '#handles?' do
    context 'when the given coordinate is one of the coordinates that starts with a queen' do
      before do
        allow(d1).to receive(:in?).and_return(true)
      end

      it 'handles' do
        expect(described_class.handles?(d1)).to eq(true)
      end
    end

    context 'when the given coordinate is not one of the coordinates that starts with a queen' do
      before do
        allow(a1).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(a1)).to eq(false)
      end
    end
  end

  describe '#valid_captures' do
    it 'returns nil' do
      expect(queen.valid_captures(a1)).to be_nil
    end
  end

  describe '#valid_en_passant_capture' do
    it 'returns nil' do
      expect(queen.valid_en_passant_capture(a1)).to be_nil
    end
  end
end
