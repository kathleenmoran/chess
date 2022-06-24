# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:black_player) { described_class.new(:black) }
  subject(:white_player) { described_class.new(:white) }

  describe '#black?' do
    context 'when the player has a black color' do
      it 'is black' do
        expect(black_player).to be_black
      end
    end

    context 'when the player does not have a black color' do
      it 'is not black' do
        expect(white_player).not_to be_black
      end
    end
  end

  describe '#white?' do
    context 'when the player has a white color' do
      it 'is white' do
        expect(white_player).to be_white
      end
    end

    context 'when the player does not have a black color' do
      it 'is not white' do
        expect(black_player).not_to be_white
      end
    end
  end

  describe '#own_piece_at_square?' do
    context 'when the colors of the player and piece at the given square are both black' do
      it 'owns the piece at the square' do
        expect(black_player).to o
      end
    end

    context 'when the colors of the player and piece at the given square are both white' do
      it 'owns the piece at the square' do

      end
    end

    context 'when the colors of the player and piece at the given square are different' do
      it 'does not own the piece at the square' do

      end
    end
  end
end