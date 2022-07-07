# frozen_string_literal: true

require_relative 'chess'
require_relative 'displayable'

# a controller to manage chess games
class Controller
  include Displayable
  def play_game
    print_welcome_to_chess_message
    case prompt_select_game_type
    when '1'
      Chess.new.play_game
    when '2'
      play_saved_game
    else
      print_invalid_response_message
      play_game
    end
    ask_to_play_again
  end

  private

  def play_saved_game
    print_file_names
    user_input = prompt_user_to_select_file
    files = Dir['saved_games/*.yaml']
    if user_input.to_i.to_s == user_input && user_input.to_i.between?(1, files.length)
      play_valid_saved_game(user_input.to_i)
    else
      print_invalid_response_message
      play_saved_game
    end
  end

  def play_valid_saved_game(file_number)
    file_name = Dir['saved_games/*.yaml'][file_number - 1]
    saved_game = open_saved_file(file_name)
    saved_game.play_game
  end

  def open_saved_file(file_name)
    print_loading_game_message(file_name.split('/')[-1])
    YAML.safe_load(
      File.open(file_name),
      aliases: true,
      permitted_classes:
        [Chess, Board, Square, Coordinate, Rook, Symbol, Knight, Bishop, Queen, King, Pawn, NoPiece, Player]
    )
  end

  def print_file_names
    puts "\n[#] File Name(s)"
    Dir['saved_games/*.yaml'].each_with_index do |game, index|
      puts "[#{index + 1}] #{game.split('/')[-1]}"
    end
  end

  def ask_to_play_again
    case prompt_play_again.downcase
    when 'y', 'yes'
      play_game
    when 'n', 'no'
      print_thanks_for_playing_message
      exit
    else
      print_invalid_response_message
      ask_to_play_again
    end
  end
end
