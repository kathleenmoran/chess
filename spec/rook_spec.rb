# frozen_string_literal: true

require_relative '../lib/rook'
require_relative '../lib/coordinate'
require_relative '../lib/player'

describe Rook do
  subject(:black_moved_rook) { described_class.new(:black, false) }
  subject(:white_unmoved_rook) { described_class.new(:white) }

  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }
  let(:a4) { instance_double(Coordinate, x: 0, y: 3) }
  let(:a7) { instance_double(Coordinate, x: 0, y: 6) }
  let(:a8) { instance_double(Coordinate, x: 0, y: 7) }

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

  let(:f1) { instance_double(Coordinate, x: 5, y: 0) }
  let(:f4) { instance_double(Coordinate, x: 5, y: 3) }
  let(:f7) { instance_double(Coordinate, x: 5, y: 6) }

  let(:g4) { instance_double(Coordinate, x: 6, y: 3) }
  let(:g7) { instance_double(Coordinate, x: 6, y: 6) }

  let(:h1) { instance_double(Coordinate, x: 7, y: 0) }
  let(:h4) { instance_double(Coordinate, x: 7, y: 3) }
  let(:h7) { instance_double(Coordinate, x: 7, y: 6) }
  let(:h8) { instance_double(Coordinate, x: 7, y: 7) }

  let(:white_player) { instance_double(Player, color: :white) }
  let(:black_player) { instance_double(Player, color: :white) }

  describe '#valid_moves' do
    context 'when the starting position is D4' do
      before do
        allow(d4).to receive(:transform).and_return(d5, d6, d7, d8, d1, d2, d3, a4, b4, c4, e4, f4, g4, h4)
      end

      it 'returns an array of valid moves from D4' do
        expect(black_moved_rook.valid_moves(d4)).to contain_exactly(
          [d5, d6, d7, d8], [d3, d2, d1], [c4, b4, a4], [e4, f4, g4, h4]
        )
      end
    end

    context 'when the starting position is B7' do
      before do
        allow(b7).to receive(:transform).and_return(b8, b1, b2, b3, b4, b5, b6, a7, c7, d7, e7, f7, g7, h7)
      end

      it 'returns an array of valid moves from B7' do
        expect(black_moved_rook.valid_moves(b7)).to contain_exactly(
          [b8], [b6, b5, b4, b3, b2, b1], [a7], [c7, d7, e7, f7, g7, h7]
        )
      end
    end
  end

  describe '#handles?' do
    context 'when the given coordinate is one of the coordinates that starts with a rook' do
      before do
        allow(a1).to receive(:in?).and_return(true)
      end

      it 'handles' do
        expect(described_class.handles?(a1)).to eq(true)
      end
    end

    context 'when the given coordinate is not one of the coordinates that starts with a rook' do
      before do
        allow(a4).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(a4)).to eq(false)
      end
    end
  end

  describe '#valid_captures' do
    it 'returns an empty array' do
      expect(white_unmoved_rook.valid_captures(a1)).to be_empty
    end
  end

  describe '#valid_en_passant_capture' do
    it 'returns nil' do
      expect(white_unmoved_rook.valid_en_passant_capture(a1)).to be_nil
    end
  end

  describe '#occupant?' do
    it 'is an occupant' do
      expect(black_moved_rook).to be_occupant
    end
  end

  describe '#handles_promotion?' do
    context "when the given string is 'rook'" do
      it 'does handle the promotion' do
        expect(described_class.handles_promotion?('rook')).to eq(true)
      end
    end

    context "when the given string is not 'rook'" do
      it 'does not handle the promotion' do
        expect(described_class.handles_promotion?('queen')).to eq(false)
      end
    end
  end

  describe '#deep_dup' do
    context 'when the rook being duplicated is black and has been moved' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(black_moved_rook.instance_variable_get(:@color), black_moved_rook.instance_variable_get(:@unmoved))
        black_moved_rook.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(black_moved_rook.deep_dup).not_to eq(black_moved_rook)
      end

      it 'returns a king' do
        expect(black_moved_rook.deep_dup).to be_kind_of(described_class)
      end

      it 'is black' do
        expect(black_moved_rook.deep_dup.instance_variable_get(:@color)).to eq(:black)
      end

      it 'has been moved' do
        expect(black_moved_rook.deep_dup.instance_variable_get(:@unmoved)).to eq(false)
      end
    end

    context 'when the king being duplicated is white and has not been moved' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(white_unmoved_rook.instance_variable_get(:@color), white_unmoved_rook.instance_variable_get(:@unmoved))
        white_unmoved_rook.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(white_unmoved_rook.deep_dup).not_to eq(white_unmoved_rook)
      end

      it 'returns a king' do
        expect(white_unmoved_rook.deep_dup).to be_kind_of(described_class)
      end

      it 'is white' do
        expect(white_unmoved_rook.deep_dup.instance_variable_get(:@color)).to eq(:white)
      end

      it 'has not been moved' do
        expect(white_unmoved_rook.deep_dup.instance_variable_get(:@unmoved)).to eq(true)
      end
    end
  end

  describe '#capturable?' do
    it 'is capturable' do
      expect(white_unmoved_rook).to be_capturable
    end
  end

  describe '#king?' do
    it 'is not a king' do
      expect(white_unmoved_rook).not_to be_king
    end
  end

  describe '#kingside_castle_move' do
    context 'when the rook has been moved' do
      it 'returns nil' do
        expect(black_moved_rook.kingside_castle_move(h8)).to be_nil
      end
    end

    context 'when the rook has not been moved' do
      before do
        allow(h1).to receive(:transform).and_return(f1)
      end

      it 'returns nil' do
        expect(white_unmoved_rook.kingside_castle_move(h1)).to eq(f1)
      end
    end
  end

  describe '#queenside_castle_move' do
    context 'when the rook has been moved' do
      it 'returns nil' do
        expect(black_moved_rook.queenside_castle_move(a8)).to be_nil
      end
    end

    context 'when the rook has not been moved' do
      before do
        allow(a1).to receive(:transform).and_return(d1)
      end

      it 'returns nil' do
        expect(white_unmoved_rook.queenside_castle_move(a1)).to eq(d1)
      end
    end
  end

  describe '#unmoved?' do
    context 'when the rook has not been moved' do
      it 'is unmoved' do
        expect(white_unmoved_rook).to be_unmoved
      end
    end

    context 'when the rook has been moved' do
      it 'is not unmoved' do
        expect(black_moved_rook).not_to be_unmoved
      end
    end
  end

  describe '#move' do
    context 'when the rook has not been moved before' do
      it 'changes ummoved to false' do
        expect { white_unmoved_rook.move(a1, b1, white_player) }
          .to change { white_unmoved_rook.instance_variable_get(:@unmoved) }.from(true).to(false)
      end
    end

    context 'when the rook has been moved before' do
      it 'does not change unmoved' do
        expect { black_moved_rook.move(b1, b8, black_player) }
          .not_to change { black_moved_rook.instance_variable_get(:@unmoved) }.from(false)
      end
    end
  end

  describe '#can_en_passant?' do
    it 'cannot en passant' do
      expect(black_moved_rook).not_to be_can_en_passant
    end
  end

  describe '#promotable?' do
    it 'cannot be promoted' do
      expect(black_moved_rook).not_to be_promotable
    end
  end

  describe '#capturable_by_en_passant?' do
    it 'cannot be captured by en passant' do
      expect(black_moved_rook).not_to be_capturable_by_en_passant
    end
  end

  describe '#can_capture_forward?' do
    it 'cannot capture forward' do
      expect(black_moved_rook).to be_can_capture_forward
    end
  end
end
