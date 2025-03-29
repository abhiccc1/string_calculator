# frozen_string_literal: true

require_relative "string_calculator/helpers"

# Calculator class that processes string inputs containing numbers and delimiters
# to calculate their sum. Supports custom delimiters and handles various input formats.
class Calculator
  include StringCalculatorHelpers

  # Custom error class for handling negative numbers in the input
  # @raise [NegativeNumberError] when negative numbers are found in the input
  class NegativeNumberError < StandardError
    def initialize(negatives)
      super("Negative numbers not allowed: #{negatives.join(", ")}")
    end
  end

  # Custom error class for handling invalid input types
  # @raise [InvalidInputError] when input is not a valid string
  class InvalidInputError < StandardError
    def initialize(no_string)
      super("Invalid input: #{no_string} is not a valid string")
    end
  end

  def add(input_string = "//;\n1;2")
    raise InvalidInputError, input_string if input.nil?
    raise InvalidInputError, input_string unless input.is_a?(String)
    return 0 if input_string.empty?

    # Execute the pipeline steps using the helper module's static methods
    components    = parse_components(input_string)
    numbers       = extract_and_convert(components)
    sum_numbers(numbers)
  end
end
