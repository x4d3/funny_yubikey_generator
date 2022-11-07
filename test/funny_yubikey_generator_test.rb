# frozen_string_literal: true

require "test_helper"

class FunnyYubikeyGeneratorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FunnyYubikeyGenerator::VERSION
  end

  YUBI_COMMAND = %r{^/(cccc([cbdefghijklnrtuv]{40}|[cbsftdhuneikpglv]{40})|jjjj[jxe.uidchtnbpygk]{40})$}

  def test_generate
    100.times do
      word = FunnyYubikeyGenerator.generate
      assert YUBI_COMMAND === word
    end
  end

  def test_with_smaller_dictionary
    dictionary = <<~DICO
      crude
      blubber
      futile
      lutrin
      interbelligerent
      reinterference
    DICO

    generator = FunnyYubikeyGenerator.new(dictionary: dictionary.split("\n"))
    100.times do
      word = generator.generate
      assert YUBI_COMMAND === word
    end
  end
end
