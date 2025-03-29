# lib/string_calculator/helpers.rb
# frozen_string_literal: true

# Helper methods for the StringCalculator pipeline
module StringCalculatorHelpers
  # Helper methods for the Calculator class

  def parse_numbers(input)
    num_array = input.split(",").map!(&:to_i)
    Calculator.raise_if_negative(num_array)
    num_array
  end
end
