# frozen_string_literal: true

require_relative '../lib/square'
require_relative '../lib/displayable'
require_relative '../lib/coordinate'
require_relative '../lib/no_piece'
require_relative '../lib/queen'

describe Square do
  let(:square_a1) { described_class.new(a1) }
  let(:square_a2) { described_class.new(a2) }
  let(:square_a8) { described_class.new(a8) }

  let(:square_b2) { described_class.new(b2) }

  let(:square_d3) { described_class.new(d3) }

  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }
  let(:a2) { instance_double(Coordinate, x: 0, y: 1) }
  let(:a8) { instance_double(Coordinate, x: 0, y: 7) }

  let(:b2) { instance_double(Coordinate, x: 1, y: 1) }

  let(:d3) { instance_double(Coordinate, x: 3, y: 2) }

  let(:queen) { instance_double(Queen, color: :white) }

  before do
    allow(a1).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [2, 3, 4, 5]).and_return(false)
    allow(a1).to receive(:in?).with([0, 7], [0, 7]).and_return(true)
    allow(a1).to receive(:y_between?).with(0, 1).and_return(true)
    allow(a1).to receive(:x_and_y_both_even_or_odd?).and_return(true)

    allow(a8).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [2, 3, 4, 5]).and_return(false)
    allow(a8).to receive(:in?).with([0, 7], [0, 7]).and_return(true)
    allow(a8).to receive(:y_between?).with(0, 1).and_return(false)
    allow(a8).to receive(:y_between?).with(6, 7).and_return(true)
    allow(a8).to receive(:x_and_y_both_even_or_odd?).and_return(false)

    allow(b2).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [2, 3, 4, 5]).and_return(false)
    allow(b2).to receive(:in?).with([0, 7], [0, 7]).and_return(false)
    allow(b2).to receive(:in?).with([3], [0, 7]).and_return(false)
    allow(b2).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [1, 6]).and_return(true)
    allow(b2).to receive(:y_between?).with(0, 1).and_return(true)
    allow(b2).to receive(:x_and_y_both_even_or_odd?).and_return(true)

    allow(d3).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [2, 3, 4, 5]).and_return(true)
    allow(d3).to receive(:y_between?).with(0, 1).and_return(false)
    allow(d3).to receive(:y_between?).with(6, 7).and_return(false)
    allow(d3).to receive(:x_and_y_both_even_or_odd?).and_return(false)
    allow(square_d3.instance_variable_get(:@piece)).to receive(:occupant?).and_return(false)
  end

  describe '#square_color' do
    context "when the given coordinate's x and y are both even" do
      it 'returns dark green' do
        expect(square_a1.square_color(a1)).to eq(:dark_green)
      end
    end

    context "when the given coordinate's x and y are both odd" do
      it 'returns dark green' do
        expect(square_b2.square_color(b2)).to eq(:dark_green)
      end
    end

    context "when the given coordinate's x and y are not both even or odd" do
      before do
        allow(a2).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [2, 3, 4, 5]).and_return(false)
        allow(a2).to receive(:in?).with([0, 7], [0, 7]).and_return(false)
        allow(a2).to receive(:in?).with([3], [0, 7]).and_return(false)
        allow(a2).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [1, 6]).and_return(true)
        allow(a2).to receive(:y_between?).with(0, 1).and_return(true)
        allow(a2).to receive(:x_and_y_both_even_or_odd?).and_return(false)
      end

      it 'returns dark green' do
        expect(square_a2.square_color(a2)).to eq(:light_green)
      end
    end
  end

  describe '#occupied?' do
    context 'when the piece is not an occupant' do
      it 'is not occupied' do
        expect(square_d3).not_to be_occupied
      end
    end

    context 'when the piece is an occupant' do
      before do
        allow(square_a1.instance_variable_get(:@piece)).to receive(:occupant?).and_return(true)
      end

      it 'is occupied' do
        expect(square_a1).to be_occupied
      end
    end
  end

  describe '#unmoved?' do
    context 'when the piece has not been moved' do
      before do
        allow(square_b2.instance_variable_get(:@piece)).to receive(:unmoved?).and_return(true)
      end

      it 'is unmoved' do
        expect(square_b2).to be_unmoved
      end
    end

    context 'when the piece has been moved' do
      before do
        allow(square_d3.instance_variable_get(:@piece)).to receive(:unmoved?).and_return(false)
      end
  
      it 'is not unmoved' do
        expect(square_d3).not_to be_unmoved
      end
    end
  end

  describe '#occupied_by_white?' do
    context 'when the piece is white' do
      before do
        allow(square_a1.instance_variable_get(:@piece)).to receive(:white?).and_return(true)
      end

      it 'is occupied by white' do
        expect(square_a1).to be_occupied_by_white
      end
    end

    context 'when the piece is not white' do
      before do
        allow(square_d3.instance_variable_get(:@piece)).to receive(:white?).and_return(false)
      end
  
      it 'is not occupied by white' do
        expect(square_d3).not_to be_occupied_by_white
      end
    end
  end

  describe '#occupied_by_black?' do
    context 'when the piece is black' do
      before do
        allow(square_a8.instance_variable_get(:@piece)).to receive(:black?).and_return(true)
      end

      it 'is occupied by black' do
        expect(square_a8).to be_occupied_by_black
      end
    end

    context 'when the piece is not black' do
      before do
        allow(square_d3.instance_variable_get(:@piece)).to receive(:black?).and_return(false)
      end
  
      it 'is not occupied by black' do
        expect(square_d3).not_to be_occupied_by_black
      end
    end
  end

  describe '#remove_piece' do
    it 'changes the piece to a no piece' do
      expect { square_a1.remove_piece }.to change(square_a1, :piece).to(NoPiece)
    end
  end

  describe '#place_piece' do
    it 'changes the piece to the given piece' do
      expect { square_a1.place_piece(queen) }.to change(square_a1, :piece).to(queen)
    end
  end

  describe '#valid_moves_of_piece' do
    it 'calls valid moves on the piece' do
      expect(square_a1.instance_variable_get(:@piece)).to receive(:valid_moves).with(square_a1.instance_variable_get(:@coordinate))
      square_a1.valid_moves_of_piece
    end
  end

  describe '#highlight' do
    it 'changes the color to the given color' do
      expect { square_a1.highlight(:neon_green) }.to change(square_a1, :color).to(:neon_green)
    end
  end

  describe '#remove_highlight' do
    before do
      allow(square_a1).to receive(:square_color).with(square_a1.instance_variable_get(:@coordinate)).and_return(:dark_green)
      square_a1.highlight(:neon_green)
    end

    it 'changes the color of the square back to its original color' do
      expect { square_a1.remove_highlight }.to change(square_a1, :color).to(:dark_green)
    end
  end
end
