# frozen_string_literal: true

# ability to display test to the console
module Displayable
  COLOR_CODES = { black: 0, dark_green: 22, light_green: 150, neon_green: 10,
                  orange: 208, red: 9, white: 231, yellow: 220 }.freeze

  def color_text(text, color)
    "\033[38;5;#{COLOR_CODES[color]}m#{text}\033[0m"
  end

  def color_background(colored_text, color)
    "\033[48;5;#{COLOR_CODES[color]}m#{colored_text}\033[0m"
  end

  def square_color(coordinate)
    if coordinate.x_and_y_both_even_or_odd?
      :dark_green
    else
      :light_green
    end
  end

  def prompt_piece_selection(player)
    puts "#{player}, enter the coordinate \nof the piece you would like \nto move (e.g., A1) or "\
     "enter \n'draw', 'save', or 'quit':"
    gets.chomp
  end

  def prompt_move_selection(player)
    puts "#{player}, enter the coordinate \nof the square you would like \nthe selected piece to move to \n(e.g., A1) or "\
    "enter 'draw', \n'save', or 'quit':"
    gets.chomp
  end

  def print_invalid_coord_message(invalid_coord)
    puts color_text("'#{invalid_coord}' is not a valid coordinate.\n", :red)
  end

  def print_invalid_start_square_message
    puts color_text("There are no valid moves originating from the given coordinate.\n", :red)
  end

  def print_invalid_move_message
    puts color_text("This is not a valid move for the selected piece.\n", :red)
  end

  def prompt_promotion_selection
    puts color_text("The pawn you have just moved is up for promotion, please enter 'queen', 'rook', "\
    "bishop', or 'knight' to promote it:", :neon_green)
    gets.chomp
  end

  def print_invalid_promotion_message
    puts color_text("That is not a valid input for piece promotion.\n", :red)
  end

  def print_invalid_response_message
    puts color_text("That is not a valid response.\n", :red)
  end

  def prompt_opponent_for_draw_response(opponent)
    puts "\n#{opponent}, your opponent has proposed a draw. Do you accept?"
    gets.chomp
  end

  def print_win_message(winner)
    puts color_text("Checkmate - #{winner} won!", :neon_green)
  end

  def print_draw_message
    puts color_text("The game has ended in a draw.\n", :yellow)
  end

  def print_stalemate_message
    puts color_text("Stalemate - The game has ended in a draw.\n", :yellow)
  end

  def print_check_message(player)
    puts color_text("Check on #{player.to_s.downcase}.\n", :yellow)
  end

  def prompt_play_again
    puts 'Would you like to play again? (Y/N)'
    gets.chomp
  end

  def print_thanks_for_playing_message
    puts "\nThanks for playing!"
  end

  def print_welcome_to_chess_message
    puts "\nWelcome to chess! This is a \ntwo-player, console-based game \nthat follows "\
    "traditional chess \nrules without time limitations.\n"
  end

  def prompt_select_game_type
    puts "\nWould you like to:\n\n[1] Play a new game\n[2] Load a saved game"
    gets.chomp
  end

  def print_save_game_message(file_name)
    puts color_text("Your game has been successfully saved in #{file_name}.\n", :neon_green)
  end

  def print_loading_game_message(file_name)
    puts "\nLoading game saved in #{file_name}..."
  end

  def prompt_user_to_select_file
    puts "\nPlease select a file number:"
    gets.chomp
  end

  def print_quit_game_message(quitter, winner)
    puts color_text("#{quitter} quit. #{winner} wins by forfeiture!\n", :neon_green)
  end
end
