# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  subject(:black_piece) { described_class.new(:black) }
  subject(:white_piece) { described_class.new(:white) }

  describe '#black?' do
    context 'when the piece has a black color' do
      it 'is black' do
        expect(black_piece).to be_black
      end
    end

    context 'when the piece does not have a black color' do
      it 'is not black' do
        expect(white_piece).not_to be_black
      end
    end
  end

  describe '#white?' do
    context 'when the piece has a white color' do
      it 'is white' do
        expect(white_piece).to be_white
      end
    end

    context 'when the piece does not have a black color' do
      it 'is not white' do
        expect(black_piece).not_to be_white
      end
    end
  end
end
