# frozen_string_literal: true

require_relative "string_calculator/helpers"

# Calculator class that processes string inputs containing numbers and delimiters
# to calculate their sum. Supports custom delimiters and handles various input formats.
class Calculator
  include StringCalculatorHelpers

  # Custom error classes
  class NegativeNumberError < StandardError
    def initialize(numbers)
      super("Negative numbers not allowed: #{numbers.join(", ")}")
    end
  end

  # Error raised when the input provided to the calculator is not a valid string
  class InvalidInputError < StandardError
    def initialize(input)
      super("Invalid input: #{input.inspect} is not a valid string")
    end
  end

  def sum_numbers(input)
    self.class.raise_invalid_input(input)
    return 0 if input.empty?

    parse_numbers(input).sum
  end

  class << self
    # Raises an error when negative numbers are found in the input
    # @param input [Array<Integer>] Array of numbers to check
    # @raise [NegativeNumberError] when negative numbers are found
    def raise_if_negative(input)
      raise NegativeNumberError, input.select(&:negative?) if input.any?(&:negative?)
    end

    # Validates that the input is a string
    # @param input [Object] The input to validate
    # @raise [InvalidInputError] when input is not a string
    def raise_invalid_input(input)
      raise InvalidInputError, input unless input.is_a?(String)
    end
  end
end
