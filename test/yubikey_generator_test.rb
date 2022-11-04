# frozen_string_literal: true

require "test_helper"

class YubikeyGeneratorTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::YubikeyGenerator::VERSION
  end

  YUBI_COMMAND = %r{^/(cccc([cbdefghijklnrtuv]{40}|[cbsftdhuneikpglv]{40})|jjjj[jxe.uidchtnbpygk]{40})$}

  def test_generate
    1000.times do
      word = YubikeyGenerator.generate(colorize: false)
      assert YUBI_COMMAND === word
    end
  end
end
