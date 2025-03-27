# frozen_string_literal: true

require "test_helper"

class TestCalculator < Minitest::Test
  def setup
    @calculator = Calculator.new
  end

  def test_that_it_has_a_version_number
    refute_nil ::StringCalculator::VERSION
  end
end
