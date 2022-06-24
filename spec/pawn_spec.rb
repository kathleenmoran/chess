# frozen_string_literal: true

require_relative '../lib/pawn'
require_relative '../lib/coordinate'

describe Pawn do
  let(:a2) { instance_double(Coordinate, x: 0, y: 1) }
  let(:a3) { instance_double(Coordinate, x: 0, y: 2) }
  subject(:unmoved_pawn) { described_class.new(:black) }

  describe '#valid_moves' do
    context "when the pawn hasn't been moved yet" do
      subject(:unmoved_pawn) { described_class.new(:black) }
      let(:start_coordinate) { instance_double(Coordinate, x: 0, y: 1) }
      let(:valid_move1) { instance_double(Coordinate, x: 0, y: 2) }
      let(:valid_move2) { instance_double(Coordinate, x: 0, y: 3) }

      before do
        allow(start_coordinate).to receive(:transform).and_return(valid_move1, valid_move2)
        allow(valid_move1).to receive(:valid?).and_return(true)
        allow(valid_move2).to receive(:valid?).and_return(true)
      end

      it 'returns two valid moves (one up and two up)' do
        expect(unmoved_pawn.valid_moves(start_coordinate)).to contain_exactly([valid_move1, valid_move2])
      end
    end

    context 'when the pawn has already moved' do
      subject(:moved_pawn) { described_class.new(:black, first_move: false) }
      let(:start_coordinate) { instance_double(Coordinate, x: 0, y: 2) }
      let(:valid_move) { instance_double(Coordinate, x: 0, y: 3) }

      before do
        allow(start_coordinate).to receive(:transform).and_return(valid_move)
        allow(valid_move).to receive(:valid?).and_return(true)
      end

      it 'returns one valid move (one up)' do
        expect(moved_pawn.valid_moves(start_coordinate)).to contain_exactly([valid_move])
      end
    end
  end

  describe '#valid_captures' do
    subject(:pawn) { described_class.new(:black) }
    context 'when both diagonals are in bounds' do
      subject(:pawn_both_captures_in_bounds) { described_class.new }
      let(:start_coordinate) { instance_double(Coordinate, x: 4, y: 1) }
      let(:valid_capture1) { instance_double(Coordinate, x: 3, y: 2) }
      let(:valid_capture2) { instance_double(Coordinate, x: 5, y: 2) }

      before do
        allow(start_coordinate).to receive(:transform).and_return(valid_capture1, valid_capture2)
        allow(valid_capture1).to receive(:valid?).and_return(true)
        allow(valid_capture2).to receive(:valid?).and_return(true)
      end

      it 'returns two valid captures (left up diagonal and right up diagonal)' do
        expect(pawn.valid_captures(start_coordinate)).to contain_exactly(valid_capture1, valid_capture2)
      end
    end

    context 'when a diagonal is out of bounds' do
      subject(:pawn_one_capture_in_bounds) { described_class.new(:black) }
      let(:start_coordinate) { instance_double(Coordinate, x: 0, y: 1) }
      let(:invalid_capture) { instance_double(Coordinate, x: -1, y: 2) }
      let(:valid_capture) { instance_double(Coordinate, x: 1, y: 2) }

      before do
        allow(start_coordinate).to receive(:transform).and_return(invalid_capture, valid_capture)
        allow(invalid_capture).to receive(:valid?).and_return(false)
        allow(valid_capture).to receive(:valid?).and_return(true)
      end

      it 'returns one valid capture (right up diagonal)' do
        expect(pawn.valid_captures(start_coordinate)).to contain_exactly(valid_capture)
      end
    end
  end

  describe '#valid_en_passant_capture' do
    subject(:pawn) { described_class.new(:black) }
    context 'when both potential en passants are in bounds' do
      let(:end_coordinate) { instance_double(Coordinate, x: 3, y: 5) }
      let(:valid_capture) { instance_double(Coordinate, x: 3, y: 4) }

      before do
        allow(end_coordinate).to receive(:transform).and_return(valid_capture)
        allow(valid_capture).to receive(:valid?).and_return(true)
      end

      it 'returns the left and right adjacent coordinates' do
        expect(pawn.valid_en_passant_capture(end_coordinate)).to eq(valid_capture)
      end
    end
  end

  describe '#handles?' do
    context 'when the given coordinate is one of the coordinates that starts with a pawn' do
      before do
        allow(a2).to receive(:in?).and_return(true)
      end

      it 'handles' do
        expect(described_class.handles?(a2)).to eq(true)
      end
    end

    context 'when the given coordinate is not one of the coordinates that starts with a pawn' do
      before do
        allow(a3).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(a3)).to eq(false)
      end
    end
  end

  describe '#occupant?' do
    it 'is an occupant' do
      expect(unmoved_pawn).to be_occupant
    end
  end
end
