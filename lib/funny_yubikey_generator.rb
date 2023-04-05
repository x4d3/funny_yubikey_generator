# frozen_string_literal: true

require "singleton"
require "colorize"

class FunnyYubikeyGenerator
  include Singleton
  COLORS = %i[red green yellow blue magenta cyan]
  LETTERS = "cbdefghijklnrtuv"
  WORD_REGEX = /^[#{Regexp.quote(LETTERS)}]+{4,}[\r\n]+/m
  private_constant :COLORS
  private_constant :LETTERS
  private_constant :WORD_REGEX

  class << self
    def from_dictionary(dictionary)
      words = filter_words(dictionary)
      new(words: words)
    end

    def filter_words(dictionary)
      dictionary.scan(WORD_REGEX).map(&:chomp)
    end

    def generate(colorize: false)
      instance.generate(colorize: colorize)
    end
  end

  def initialize(words: load_default_words)
    @indexed_words = words.group_by(&:length)
  end

  def generate(colorize: false)
    words = random_partition(40, @indexed_words.keys).map do |s|
      @indexed_words[s].sample
    end
    if colorize
      words.map!.with_index { |w, i| w.colorize(COLORS[i % COLORS.length]) }
    end
    "/cccc#{words.join}"
  end

  private

  def load_default_words
    default_file_path = File.join(__dir__, "words.txt")
    File.readlines(default_file_path, chomp: true)
  end

  def random_partition(target, word_lengths)
    min = word_lengths.min
    100.times do
      result = []
      left_over = target
      while left_over > 0
        word_length = word_lengths.filter { |s| s <= left_over && (left_over - s) >= min }.sample
        if word_length
          result << word_length
          left_over -= word_length
        elsif word_lengths.include?(left_over)
          result << left_over
          return result
        else
          # Could not find a candidate, trying again
          break
        end
      end
    end
    raise "could not generate partition of #{target} with #{word_lengths} after 100 attempts"
  end
end
