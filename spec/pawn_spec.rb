# frozen_string_literal: true

require_relative '../lib/pawn'
require_relative '../lib/coordinate'
require_relative '../lib/player'

describe Pawn do
  let(:a2) { instance_double(Coordinate, x: 0, y: 1) }
  let(:a3) { instance_double(Coordinate, x: 0, y: 2) }
  let(:a4) { instance_double(Coordinate, x: 0, y: 3) }
  let(:a5) { instance_double(Coordinate, x: 0, y: 4) }
  let(:a7) { instance_double(Coordinate, x: 0, y: 6) }

  subject(:black_unmoved_pawn) { described_class.new(:black) }
  subject(:white_moved_pawn) { described_class.new(:white, false, true, 1) }
  subject(:white_moved_by_one_pawn) { described_class.new(:white, false, false, 1) }

  let(:white_player) { instance_double(Player, color: :white) }
  let(:black_player) { instance_double(Player, color: :white) }

  describe '#valid_moves' do
    context "when the pawn hasn't been moved yet" do
      subject(:black_unmoved_pawn) { described_class.new(:black) }
      let(:start_coordinate) { instance_double(Coordinate, x: 0, y: 1) }
      let(:valid_move1) { instance_double(Coordinate, x: 0, y: 2) }
      let(:valid_move2) { instance_double(Coordinate, x: 0, y: 3) }

      before do
        allow(start_coordinate).to receive(:transform).and_return(valid_move1, valid_move2)
        allow(valid_move1).to receive(:valid?).and_return(true)
        allow(valid_move2).to receive(:valid?).and_return(true)
      end

      it 'returns two valid moves (one up and two up)' do
        expect(black_unmoved_pawn.valid_moves(start_coordinate)).to contain_exactly([valid_move1, valid_move2])
      end
    end

    context 'when the pawn has already moved' do
      subject(:moved_pawn) { described_class.new(:black, false) }
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
      expect(black_unmoved_pawn).to be_occupant
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
    context 'when the pawn being duplicated is black and has not been moved' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(
            black_unmoved_pawn.instance_variable_get(:@color),
            black_unmoved_pawn.instance_variable_get(:@unmoved),
            black_unmoved_pawn.instance_variable_get(:@moved_by_two),
            black_unmoved_pawn.instance_variable_get(:@move_count)
          )
        black_unmoved_pawn.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(black_unmoved_pawn.deep_dup).not_to eq(black_unmoved_pawn)
      end

      it 'returns a pawn' do
        expect(black_unmoved_pawn.deep_dup).to be_kind_of(described_class)
      end

      it 'is black' do
        expect(black_unmoved_pawn.deep_dup.instance_variable_get(:@color)).to eq(:black)
      end

      it 'has not been moved' do
        expect(black_unmoved_pawn.deep_dup.instance_variable_get(:@unmoved)).to eq(true)
      end

      it 'has been moved by two' do
        expect(black_unmoved_pawn.deep_dup.instance_variable_get(:@moved_by_two)).to eq(false)
      end

      it 'has made one move' do
        expect(black_unmoved_pawn.deep_dup.instance_variable_get(:@move_count)).to eq(0)
      end
    end

    context 'when the king being duplicated is white and has been moved once, by two' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(
            white_moved_pawn.instance_variable_get(:@color),
            white_moved_pawn.instance_variable_get(:@unmoved),
            white_moved_pawn.instance_variable_get(:@moved_by_two),
            white_moved_pawn.instance_variable_get(:@move_count)
          )
        white_moved_pawn.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(white_moved_pawn.deep_dup).not_to eq(white_moved_pawn)
      end

      it 'returns a pawn' do
        expect(white_moved_pawn.deep_dup).to be_kind_of(described_class)
      end

      it 'is white' do
        expect(white_moved_pawn.deep_dup.instance_variable_get(:@color)).to eq(:white)
      end

      it 'has been moved' do
        expect(white_moved_pawn.deep_dup.instance_variable_get(:@unmoved)).to eq(false)
      end

      it 'has been moved by two' do
        expect(white_moved_pawn.deep_dup.instance_variable_get(:@moved_by_two)).to eq(true)
      end

      it 'has made one move' do
        expect(white_moved_pawn.deep_dup.instance_variable_get(:@move_count)).to eq(1)
      end
    end
  end

  describe '#capturable?' do
    it 'is capturable' do
      expect(white_moved_pawn).to be_capturable
    end
  end

  describe '#king?' do
    it 'is not a king' do
      expect(white_moved_pawn).not_to be_king
    end
  end

  describe '#kingside_castle_move' do
    it 'returns nil' do
      expect(white_moved_pawn.kingside_castle_move(a2)).to be_nil
    end
  end

  describe '#queenside_castle_move' do
    it 'returns nil' do
      expect(black_unmoved_pawn.queenside_castle_move(a2)).to be_nil
    end
  end

  describe '#unmoved?' do
    context 'when the pawn has not been moved' do
      it 'is unmoved' do
        expect(black_unmoved_pawn).to be_unmoved
      end
    end

    context 'when the pawn has been moved' do
      it 'is not unmoved' do
        expect(white_moved_pawn).not_to be_unmoved
      end
    end
  end

  describe '#move' do
    context 'when the rook has not been moved before and is moved by two' do
      before do
        allow(a7).to receive(:moved_two_vertically?).with(a5).and_return(true)
      end

      it 'changes ummoved to false' do
        expect { black_unmoved_pawn.move(a7, a5, black_player) }
          .to change { black_unmoved_pawn.instance_variable_get(:@unmoved) }.from(true).to(false)
      end

      it 'changes moved_by_two to true' do
        expect { black_unmoved_pawn.move(a7, a5, black_player) }
          .to change { black_unmoved_pawn.instance_variable_get(:@moved_by_two) }.from(false).to(true)
      end

      it 'increases the move count by 1' do
        expect { black_unmoved_pawn.move(a7, a5, black_player) }
          .to change { black_unmoved_pawn.instance_variable_get(:@move_count) }.by(1)
      end
    end

    context 'when the rook has been moved before' do
      before do
        allow(a3).to receive(:moved_two_vertically?).with(a4).and_return(false)
      end
  
      it 'does not change unmoved' do
        expect { white_moved_by_one_pawn.move(a3, a4, white_player) }
          .not_to change { white_moved_pawn.instance_variable_get(:@unmoved) }.from(false)
      end

      it 'does not change moved_by_two' do
        expect { white_moved_by_one_pawn.move(a3, a4, white_player) }
          .not_to change { white_moved_by_one_pawn.instance_variable_get(:@moved_by_two) }.from(false)
      end

      it 'changes the move count by 1' do
        expect { white_moved_by_one_pawn.move(a3, a4, white_player) }
          .to change { white_moved_by_one_pawn.instance_variable_get(:@move_count) }.by(1)
      end
    end
  end

  describe '#can_en_passant?' do
    it 'cannot en passant' do
      expect(white_moved_by_one_pawn).to be_can_en_passant
    end
  end

  describe '#promotable?' do
    it 'can be promoted' do
      expect(white_moved_by_one_pawn).to be_promotable
    end
  end
end
