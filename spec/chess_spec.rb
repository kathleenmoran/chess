# frozen_string_literal: true

require_relative '../lib/chess.rb'

describe Chess do
  subject(:game) { described_class.new }

  describe '#play_game' do
    context 'when there is a check after 4 turns and a checkmate after 5 turns' do
      before do
        allow(game.instance_variable_get(:@board)).to receive(:stalemate?).and_return(false)
        allow(game.instance_variable_get(:@board)).to receive(:checkmate?).and_return(false, false, false, false, true)
        allow(game.instance_variable_get(:@board)).to receive(:check?).and_return(false, false, false, true)
        allow(game).to receive(:play_turn)
        allow($stdout).to receive(:write)
      end

      it 'prints the board twice' do
        expect(game.instance_variable_get(:@board)).to receive(:to_s).twice
        game.play_game
      end

      it 'changes the active player 4 times' do
        expect(game).to receive(:change_active_player).exactly(4).times
        game.play_game
      end

      it 'plays 4 turns' do
        expect(game).to receive(:play_turn).exactly(4).times
        game.play_game
      end

      it 'prints the check message once' do
        expect(game).to receive(:print_check_message).once
        game.play_game
      end

      it 'prints the end game message once' do
        expect(game).to receive(:print_end_game_message).once
        game.play_game
      end
    end

    context 'where is a stalemate after 7 turns' do
      before do
        allow(game.instance_variable_get(:@board)).to receive(:stalemate?).and_return(false, false, false, false, false, false, false, true)
        allow(game.instance_variable_get(:@board)).to receive(:checkmate?).and_return(false)
        allow(game.instance_variable_get(:@board)).to receive(:check?).and_return(false)
        allow(game).to receive(:play_turn)
        allow($stdout).to receive(:write)
      end

      it 'prints the board twice' do
        expect(game.instance_variable_get(:@board)).to receive(:to_s).twice
        game.play_game
      end

      it 'changes the active player 7 times' do
        expect(game).to receive(:change_active_player).exactly(7).times
        game.play_game
      end

      it 'plays 7 turns' do
        expect(game).to receive(:play_turn).exactly(7).times
        game.play_game
      end

      it 'does not print the check message' do
        expect(game).not_to receive(:print_check_message)
        game.play_game
      end

      it 'prints the end game message once' do
        expect(game).to receive(:print_end_game_message).once
        game.play_game
      end
    end
  end
end