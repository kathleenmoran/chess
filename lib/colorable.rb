# frozen_string_literal: true

# ability to color text using ANSI escape codes
module Colorable
  COLOR_CODES = { black: 0, dark_green: 22, light_green: 150, neon_green: 10, red: 9, white: 231, yellow: 220 }.freeze

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
    puts "#{player}, enter the coordinate of the piece you would like to move (e.g., A1):"
    gets.chomp
  end

  def prompt_move_selection(player)
    puts "#{player}, enter the coordinate of the square you would like the selected piece to move to (e.g., A1):"
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
end
