# frozen_string_literal: true

require "test_helper"

class FunnyYubikeyGeneratorTest < Minitest::Test
  YUBI_COMMAND = %r{^/(cccc([cbdefghijklnrtuv]{40}|[cbsftdhuneikpglv]{40})|jjjj[jxe.uidchtnbpygk]{40})$}

  def test_generate
    1000.times do
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

    generator = FunnyYubikeyGenerator.from_dictionary(dictionary)
    1000.times do
      word = generator.generate
      assert YUBI_COMMAND === word
    end
  end

  def test_with_different_ending
    dictionary = File.read(File.expand_path("./francais.txt", __dir__))
    generator = FunnyYubikeyGenerator.from_dictionary(dictionary)
    100.times do
      word = generator.generate
      assert YUBI_COMMAND === word
    end
  end
end
