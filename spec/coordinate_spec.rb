# frozen_string_literal: true

require_relative '../lib/coordinate'

describe Coordinate do
  subject(:d4) { described_class.new(3, 3) }
  subject(:c1) { described_class.new(2, 0) }
  subject(:b7) { described_class.new(1, 6) }

  describe '#transform' do
    subject(:transform_coordinate) { described_class.new(5, 5) }

    context 'when given a positive x increment and a positive y increment' do
      it 'returns a new coordinate with the increments added to the coordinates' do
        expect(transform_coordinate.transform(2, 4)).to eq(described_class.new(7, 9))
      end
    end

    context 'when given a positive x increment and a negative y increment' do
      it 'returns a new coordinate with the increments added to the coordinates' do
        expect(transform_coordinate.transform(3, -4)).to eq(described_class.new(8, 1))
      end
    end

    context 'when given a negative x increment and a positive y increment' do
      it 'returns a new coordinate with the increments added to the coordinates' do
        expect(transform_coordinate.transform(-4, 5)).to eq(described_class.new(1, 10))
      end
    end

    context 'when given a negative x increment and a negative y increment' do
      it 'returns a new coordinate with the increments added to the coordinates' do
        expect(transform_coordinate.transform(-2, -4)).to eq(described_class.new(3, 1))
      end
    end

    context 'when given a x increment of 0 and a y increment of 0' do
      it 'returns a new coordinate with the increments added to the coordinates' do
        expect(transform_coordinate.transform(0, 0)).to eq(described_class.new(5, 5))
      end
    end
  end

  describe '#valid?' do
    context "when the coordinate's x and y are 0" do
      subject(:coordinate00) { described_class.new(0, 0) }
      it 'is valid' do
        expect(coordinate00).to be_valid
      end
    end

    context "when the coordinate's x and y are 7" do
      subject(:coordinate77) { described_class.new(7, 7) }
      it 'is valid' do
        expect(coordinate77).to be_valid
      end
    end

    context "when the coordinate's x is in bounds and y is out of bounds" do
      subject(:coordinate3neg1) { described_class.new(3, -1) }
      it 'is not valid' do
        expect(coordinate3neg1).not_to be_valid
      end
    end

    context "when the coordinate's x is out of bounds and y is in bounds" do
      subject(:coordinate86) { described_class.new(8, 6) }
      it 'is not valid' do
        expect(coordinate86).not_to be_valid
      end
    end

    context "when the coordinate's x and y are both out of bounds" do
      subject(:coordinate_large_out_of_bounds) { described_class.new(-100, 100) }
      it 'is not valid' do
        expect(coordinate_large_out_of_bounds).not_to be_valid
      end
    end
  end

  describe '#min_coordinate' do
    context 'when the x coordinate is the smaller coordinate' do
      subject(:small_x_coordinate) { described_class.new(5, 10) }
      it 'returns the value of the x coordinate' do
        expect(small_x_coordinate.min_coordinate).to be(5)
      end
    end

    context 'when the y coordinate is the smaller coordinate' do
      subject(:small_y_coordinate) { described_class.new(7, 2) }
      it 'returns the value of the y coordinate' do
        expect(small_y_coordinate.min_coordinate).to be(2)
      end
    end

    context 'when the x coordinate and y coordinate have the same value' do
      subject(:same_coordinate) { described_class.new(0, 0) }
      it 'returns the value of the x and y coordinate' do
        expect(same_coordinate.min_coordinate).to be(0)
      end
    end
  end

  describe '#past_x?' do
    subject(:smaller_x) { described_class.new(1, 0) }
    subject(:larger_x) { described_class.new(2, 0) }
    subject(:same_as_smaller_x) { described_class.new(1, 0) }

    context "when the given coordinate's x is larger than the coordinate's x" do
      it 'is not past x' do
        expect(smaller_x).not_to be_past_x(larger_x)
      end
    end

    context "when the given coordinate's x is smaller than the coordinate's x" do
      it 'is past x' do
        expect(larger_x).to be_past_x(smaller_x)
      end
    end

    context "when the given coordinate's x is the same as the coordinate's x" do
      it 'is not past x' do
        expect(smaller_x).not_to be_past_x(same_as_smaller_x)
      end
    end
  end

  describe '#past_y?' do
    subject(:smaller_y) { described_class.new(0, 1) }
    subject(:larger_y) { described_class.new(0, 2) }
    subject(:same_as_smaller_y) { described_class.new(0, 1) }

    context "when the given coordinate's y is larger than the coordinate's y" do
      it 'is not past y' do
        expect(smaller_y).not_to be_past_y(larger_y)
      end
    end

    context "when the given coordinate's y is smaller than the coordinate's y" do
      it 'is past y' do
        expect(larger_y).to be_past_y(smaller_y)
      end
    end

    context "when the given coordinate's y is the same as the coordinate's y" do
      it 'is not past y' do
        expect(smaller_y).not_to be_past_y(same_as_smaller_y)
      end
    end
  end

  describe '#y_between?' do
    context "when the coordinate's y is between the given min and max" do
      it 'is between' do
        expect(d4).to be_y_between(2, 3)
      end
    end

    context "when the coordinate's y is not between the given min and max" do
      it 'is not between' do
        expect(d4).not_to be_y_between(6, 7)
      end
    end
  end

  describe '#in?' do
    context "when the coordinate's x and y are both in the respective arrays provided" do
      it 'is in' do
        expect(d4).to be_in([1, 3, 5], [0, 3, 6])
      end
    end

    context "when the coordinate's x is not in the respective array" do
      it 'is not in' do
        expect(d4).not_to be_in([1, 2, 5], [0, 3, 6])
      end
    end

    context "when the coordinate's y is not in the respective array" do
      it 'is not in' do
        expect(d4).not_to be_in([1, 3, 5], [0, 6])
      end
    end
  end

  describe '#x_and_y_both_even_or_odd?' do
    context 'when x and y are both odd' do
      it 'is both odd' do
        expect(d4).to be_x_and_y_both_even_or_odd
      end
    end

    context 'when x and y are both even' do
      it 'is both even' do
        expect(c1).to be_x_and_y_both_even_or_odd
      end
    end

    context 'when one coordinate is even and the other is odd' do
      it 'is not both odd or even' do
        expect(b7).not_to be_x_and_y_both_even_or_odd
      end
    end
  end
end
