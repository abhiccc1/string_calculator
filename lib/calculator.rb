# frozen_string_literal: true

require_relative "string_calculator/version"

# Calculator class that processes string inputs containing numbers and delimiters
# to calculate their sum. Supports custom delimiters and handles various input formats.
class Calculator
  include StringCalculator

  # Custom error class for handling negative numbers in the input
  # @raise [NegativeNumberError] when negative numbers are found in the input
  class NegativeNumberError < StandardError
    def initialize(negatives)
      super("Negative numbers not allowed: #{negatives.join(", ")}")
    end
  end

  def add(input_string)
    begin_input(input_string)
  end
end
