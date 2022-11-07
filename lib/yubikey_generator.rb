# frozen_string_literal: true

require "singleton"
require "colorize"
require "set"

class YubikeyGenerator
  VERSION = "0.1.0"

  include Singleton

  COLORS = %i[red green yellow blue magenta cyan]
  private_constant :COLORS

  class << self
    def generate(colorize: true)
      instance.generate(colorize: colorize)
    end
  end

  def initialize(dictionary: nil, letters: "cbdefghijklnrtuv".chars.to_set)
    input = dictionary || File.open(File.join(__dir__, "words.txt"))
    @dictionary = input.map(&:strip).select { |line|
      line.chars.all? do |c|
        letters.include?(c)
      end
    }.group_by(&:length)
  end

  def generate(colorize: true)
    words_lengths = @dictionary.keys
    words = random_partition(40, words_lengths).map do |s|
      @dictionary[s].sample
    end
    if colorize
      words.map!.with_index { |w, i| w.colorize(COLORS[i % COLORS.length]) }
    end
    "/cccc#{words.join}"
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
