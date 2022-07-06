# frozen_string_literal: true

require_relative '../lib/square'
require_relative '../lib/displayable'
require_relative '../lib/coordinate'

describe Square do
  let(:square_a1) { described_class.new(a1) }
  let(:square_a2) { described_class.new(a2) }

  let(:square_b2) { described_class.new(b2) }

  let(:a1) { instance_double(Coordinate, x: 0, y: 0) }
  let(:a2) { instance_double(Coordinate, x: 0, y: 1) }

  let(:b2) { instance_double(Coordinate, x: 1, y: 1) }

  describe '#square_color' do
    context "when the given coordinate's x and y are both even" do
      before do
        allow(a1).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [2, 3, 4, 5]).and_return(false)
        allow(a1).to receive(:in?).with([0, 7], [0, 7]).and_return(true)
        allow(a1).to receive(:y_between?).with(0, 1).and_return(true)
        allow(a1).to receive(:x_and_y_both_even_or_odd?).and_return(true)
      end

      it 'returns dark green' do
        expect(square_a1.square_color(a1)).to eq(:dark_green)
      end
    end

    context "when the given coordinate's x and y are both odd" do
      before do
        allow(b2).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [2, 3, 4, 5]).and_return(false)
        allow(b2).to receive(:in?).with([0, 7], [0, 7]).and_return(false)
        allow(b2).to receive(:in?).with([3], [0, 7]).and_return(false)
        allow(b2).to receive(:in?).with([0, 1, 2, 3, 4, 5, 6, 7], [1, 6]).and_return(true)
        allow(b2).to receive(:y_between?).with(0, 1).and_return(true)
        allow(b2).to receive(:x_and_y_both_even_or_odd?).and_return(true)
      end

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
end
