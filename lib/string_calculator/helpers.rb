# lib/string_calculator/helpers.rb
# frozen_string_literal: true

# Helper methods for the StringCalculator pipeline
module StringCalculatorHelpers
  # Helper methods for the Calculator class

  def parse_components(input)
    # To do
  end

  def extract_and_convert(components)
    raise NegativeNumberError, components[1] if components[1].any?(&:negative?)
    # To do
  end

  def sum_numbers(input)
    # To do
  end
end
