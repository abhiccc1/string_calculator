# frozen_string_literal: true

require "test_helper"

class StringCalculatorHelpersTest < Minitest::Test
  class TestClass
    include StringCalculatorHelpers
  end

  def setup
    @helper = TestClass.new
  end

  def test_parse_numbers
    assert_equal [1, 2, 3], @helper.parse_numbers("1,2,3")
    assert_equal [42], @helper.parse_numbers("42")
    assert_equal [], @helper.parse_numbers("")
  end
end
