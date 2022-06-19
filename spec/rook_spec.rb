# frozen_string_literal: true

require_relative '../lib/rook'
require_relative '../lib/coordinate'

describe Rook do
  describe '#valid_moves' do
    subject(:rook) { described_class.new }

    let(:a4) { instance_double(Coordinate, x: 0, y: 3) }
    let(:a7) { instance_double(Coordinate, x: 0, y: 6) }

    let(:b1) { instance_double(Coordinate, x: 1, y: 0) }
    let(:b2) { instance_double(Coordinate, x: 1, y: 1) }
    let(:b3) { instance_double(Coordinate, x: 1, y: 2) }
    let(:b4) { instance_double(Coordinate, x: 1, y: 3) }
    let(:b5) { instance_double(Coordinate, x: 1, y: 4) }
    let(:b6) { instance_double(Coordinate, x: 1, y: 5) }
    let(:b7) { instance_double(Coordinate, x: 1, y: 6) }
    let(:b8) { instance_double(Coordinate, x: 1, y: 7) }

    let(:c4) { instance_double(Coordinate, x: 2, y: 3) }
    let(:c7) { instance_double(Coordinate, x: 2, y: 6) }

    let(:d1) { instance_double(Coordinate, x: 3, y: 0) }
    let(:d2) { instance_double(Coordinate, x: 3, y: 1) }
    let(:d3) { instance_double(Coordinate, x: 3, y: 2) }
    let(:d4) { instance_double(Coordinate, x: 3, y: 3) }
    let(:d5) { instance_double(Coordinate, x: 3, y: 4) }
    let(:d6) { instance_double(Coordinate, x: 3, y: 5) }
    let(:d7) { instance_double(Coordinate, x: 3, y: 6) }
    let(:d8) { instance_double(Coordinate, x: 3, y: 7) }

    let(:e4) { instance_double(Coordinate, x: 4, y: 3) }
    let(:e7) { instance_double(Coordinate, x: 4, y: 6) }

    let(:f4) { instance_double(Coordinate, x: 5, y: 3) }
    let(:f7) { instance_double(Coordinate, x: 5, y: 6) }

    let(:g4) { instance_double(Coordinate, x: 6, y: 3) }
    let(:g7) { instance_double(Coordinate, x: 6, y: 6) }

    let(:h4) { instance_double(Coordinate, x: 7, y: 3) }
    let(:h7) { instance_double(Coordinate, x: 7, y: 6) }

    context 'when the starting position is D4' do
      before do
        allow(d4).to receive(:transform).and_return(d5, d6, d7, d8, d1, d2, d3, a4, b4, c4, e4, f4, g4, h4)
      end

      it 'returns an array of valid moves from D4' do
        expect(rook.valid_moves(d4)).to contain_exactly(
          [d5, d6, d7, d8], [d3, d2, d1], [c4, b4, a4], [e4, f4, g4, h4]
        )
      end
    end

    context 'when the starting position is B7' do
      before do
        allow(b7).to receive(:transform).and_return(b8, b1, b2, b3, b4, b5, b6, a7, c7, d7, e7, f7, g7, h7)
      end

      it 'returns an array of valid moves from B7' do
        expect(rook.valid_moves(b7)).to contain_exactly(
          [b8], [b6, b5, b4, b3, b2, b1], [a7], [c7, d7, e7, f7, g7, h7]
        )
      end
    end
  end
end
