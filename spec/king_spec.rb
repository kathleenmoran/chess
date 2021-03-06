# frozen_string_literal: true

require_relative '../lib/king'
require_relative '../lib/coordinate'
require_relative '../lib/player'

describe King do
  subject(:black_moved_king) { described_class.new(:black, false) }
  subject(:white_unmoved_king) { described_class.new(:white) }

  let(:a7) { instance_double(Coordinate, x: 0, y: 6) }
  let(:a8) { instance_double(Coordinate, x: 0, y: 7) }

  let(:b7) { instance_double(Coordinate, x: 1, y: 6) }
  let(:b8) { instance_double(Coordinate, x: 1, y: 7) }

  let(:c1) { instance_double(Coordinate, x: 2, y: 0) }
  let(:c3) { instance_double(Coordinate, x: 2, y: 2) }
  let(:c4) { instance_double(Coordinate, x: 2, y: 3) }
  let(:c5) { instance_double(Coordinate, x: 2, y: 4) }

  let(:d3) { instance_double(Coordinate, x: 3, y: 2) }
  let(:d4) { instance_double(Coordinate, x: 3, y: 3) }
  let(:d5) { instance_double(Coordinate, x: 3, y: 4) }

  let(:e1) { instance_double(Coordinate, x: 4, y: 0) }
  let(:e2) { instance_double(Coordinate, x: 4, y: 1) }
  let(:e3) { instance_double(Coordinate, x: 4, y: 2) }
  let(:e4) { instance_double(Coordinate, x: 4, y: 3) }
  let(:e5) { instance_double(Coordinate, x: 4, y: 4) }
  let(:e8) { instance_double(Coordinate, x: 4, y: 7) }

  let(:g1) { instance_double(Coordinate, x: 6, y: 0) }

  let(:invalid1) { instance_double(Coordinate, x: -1, y: 6) }
  let(:invalid2) { instance_double(Coordinate, x: -1, y: 7) }
  let(:invalid3) { instance_double(Coordinate, x: -1, y: 8) }
  let(:invalid4) { instance_double(Coordinate, x: 0, y: 8) }
  let(:invalid5) { instance_double(Coordinate, x: 1, y: 8) }

  let(:white_player) { instance_double(Player, color: :white) }
  let(:black_player) { instance_double(Player, color: :white) }

  describe '#valid_moves' do
    context 'when the king has a starting position of D4' do
      before do
        allow(d4).to receive(:transform).and_return(c3, c4, c5, d3, d5, e3, e4, e5)
        allow(c3).to receive(:valid?).and_return(true)
        allow(c4).to receive(:valid?).and_return(true)
        allow(c5).to receive(:valid?).and_return(true)
        allow(d3).to receive(:valid?).and_return(true)
        allow(d5).to receive(:valid?).and_return(true)
        allow(e3).to receive(:valid?).and_return(true)
        allow(e4).to receive(:valid?).and_return(true)
        allow(e5).to receive(:valid?).and_return(true)
      end

      it 'returns a nested array of valid moves from D4' do
        expect(black_moved_king.valid_moves(d4)).to contain_exactly([c3], [c4], [c5], [d3], [d5], [e3], [e4], [e5])
      end
    end

    context 'when the king has a starting position of A8' do
      before do
        allow(a8).to receive(:transform).and_return(invalid1, invalid2, invalid3, a7, invalid4, b7, b8, invalid5)
        allow(invalid1).to receive(:valid?).and_return(false)
        allow(invalid2).to receive(:valid?).and_return(false)
        allow(invalid3).to receive(:valid?).and_return(false)
        allow(a7).to receive(:valid?).and_return(true)
        allow(invalid4).to receive(:valid?).and_return(false)
        allow(b7).to receive(:valid?).and_return(true)
        allow(b8).to receive(:valid?).and_return(true)
        allow(invalid5).to receive(:valid?).and_return(false)
      end

      it 'returns a nested array of valid moves from A8' do
        expect(black_moved_king.valid_moves(a8)).to contain_exactly([a7], [b7], [b8])
      end
    end
  end

  describe '#handles?' do
    context 'when the given coordinate is one of the coordinates that starts with a king' do
      before do
        allow(e1).to receive(:in?).and_return(true)
      end

      it 'handles' do
        expect(described_class.handles?(e1)).to eq(true)
      end
    end

    context 'when the given coordinate is not one of the coordinates that starts with a king' do
      before do
        allow(a7).to receive(:in?).and_return(false)
      end

      it 'does not handle' do
        expect(described_class.handles?(a7)).to eq(false)
      end
    end
  end

  describe '#valid_captures' do
    it 'returns an empty array' do
      expect(black_moved_king.valid_captures(a7)).to be_empty
    end
  end

  describe '#valid_en_passant_capture' do
    it 'returns nil' do
      expect(black_moved_king.valid_en_passant_capture(a7)).to be_nil
    end
  end

  describe '#occupant?' do
    it 'is an occupant' do
      expect(black_moved_king).to be_occupant
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
    context 'when the king being duplicated is black and has been moved' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(black_moved_king.instance_variable_get(:@color), black_moved_king.instance_variable_get(:@unmoved))
        black_moved_king.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(black_moved_king.deep_dup).not_to eq(black_moved_king)
      end

      it 'returns a king' do
        expect(black_moved_king.deep_dup).to be_kind_of(described_class)
      end

      it 'is black' do
        expect(black_moved_king.deep_dup.instance_variable_get(:@color)).to eq(:black)
      end

      it 'has been moved' do
        expect(black_moved_king.deep_dup.instance_variable_get(:@unmoved)).to eq(false)
      end
    end

    context 'when the king being duplicated is white and has not been moved' do
      it 'calls new on the described class' do
        expect(described_class)
          .to receive(:new)
          .with(white_unmoved_king.instance_variable_get(:@color), white_unmoved_king.instance_variable_get(:@unmoved))
        white_unmoved_king.deep_dup
      end

      it 'returns an object that is not equal to the original' do
        expect(white_unmoved_king.deep_dup).not_to eq(white_unmoved_king)
      end

      it 'returns a king' do
        expect(white_unmoved_king.deep_dup).to be_kind_of(described_class)
      end

      it 'is white' do
        expect(white_unmoved_king.deep_dup.instance_variable_get(:@color)).to eq(:white)
      end

      it 'has not been moved' do
        expect(white_unmoved_king.deep_dup.instance_variable_get(:@unmoved)).to eq(true)
      end
    end
  end

  describe '#capturable?' do
    it 'is not capturable' do
      expect(white_unmoved_king).not_to be_capturable
    end
  end

  describe '#king?' do
    it 'is a king' do
      expect(white_unmoved_king).to be_king
    end
  end


  describe '#kingside_castle_move' do
    context 'when the king has been moved' do
      it 'returns nil' do
        expect(black_moved_king.kingside_castle_move(e8)).to be_nil
      end
    end

    context 'when the king has not been moved' do
      before do
        allow(e1).to receive(:transform).and_return(g1)
      end

      it 'returns nil' do
        expect(white_unmoved_king.kingside_castle_move(e1)).to eq(g1)
      end
    end
  end

  describe '#queenside_castle_move' do
    context 'when the king has been moved' do
      it 'returns nil' do
        expect(black_moved_king.queenside_castle_move(e8)).to be_nil
      end
    end

    context 'when the king has not been moved' do
      before do
        allow(e1).to receive(:transform).and_return(c1)
      end

      it 'returns nil' do
        expect(white_unmoved_king.queenside_castle_move(e1)).to eq(c1)
      end
    end
  end

  describe '#unmoved?' do
    context 'when the king has not been moved' do
      it 'is unmoved' do
        expect(white_unmoved_king).to be_unmoved
      end
    end

    context 'when the king has been moved' do
      it 'is not unmoved' do
        expect(black_moved_king).not_to be_unmoved
      end
    end
  end

  describe '#move' do
    context 'when the king has not been moved before' do
      it 'changes ummoved to false' do
        expect { white_unmoved_king.move(e1, e2, white_player) }
          .to change { white_unmoved_king.instance_variable_get(:@unmoved) }.from(true).to(false)
      end
    end

    context 'when the king has been moved before' do
      it 'does not change unmoved' do
        expect { black_moved_king.move(e1, e2, black_player) }
          .not_to change { black_moved_king.instance_variable_get(:@unmoved) }.from(false)
      end
    end
  end

  describe '#can_en_passant?' do
    it 'cannot en passant' do
      expect(black_moved_king).not_to be_can_en_passant
    end
  end

  describe '#promotable?' do
    it 'cannot be promoted' do
      expect(black_moved_king).not_to be_promotable
    end
  end

  describe '#capturable_by_en_passant?' do
    it 'cannot be captured by en passant' do
      expect(black_moved_king).not_to be_capturable_by_en_passant
    end
  end

  describe '#can_capture_forward?' do
    it 'can capture forward' do
      expect(black_moved_king).to be_can_capture_forward
    end
  end
end
