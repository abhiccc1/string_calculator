# frozen_string_literal: true

require "test_helper"

class CalculatorTest < Minitest::Test
  def test_sum_numbers_with_valid_input
    calculator = Calculator.new
    assert_equal 6, calculator.sum_numbers("1,2,3")
    assert_equal 0, calculator.sum_numbers("")
    assert_equal 42, calculator.sum_numbers("42")
  end

  def test_raises_error_for_negative_numbers
    error = assert_raises(Calculator::NegativeNumberError) do
      Calculator.raise_if_negative([-1, 2, -3])
    end
    assert_match(/Negative numbers not allowed: -1, -3/, error.message)
  end

  def test_raises_error_for_invalid_input_type
    [nil, 123, [], {}].each do |invalid_input|
      error = assert_raises(Calculator::InvalidInputError) do
        Calculator.raise_invalid_input(invalid_input)
      end
      assert_match(/Invalid input: .+ is not a valid string/, error.message)
    end
  end
end
