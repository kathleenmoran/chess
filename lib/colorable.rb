# frozen_string_literal: true

# ability to color text using ANSI escape codes
module Colorable
  COLOR_CODES = { black: 0, dark_green: 22, light_green: 150, white: 231 }.freeze

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
end
