# frozen_string_literal: true

require "singleton"
require "colorize"
require "set"
require "yaml"

class FunnyYubikeyGenerator
  include Singleton
  VERSION = "0.3.0"
  COLORS = %i[red green yellow blue magenta cyan]
  LETTERS = "cbdefghijklnrtuv".chars.to_set

  private_constant :COLORS
  private_constant :LETTERS

  class << self
    def from_dictionary(dictionary)
      indexed_words = filter_and_index_words(dictionary)
      new(indexed_words: indexed_words)
    end

    def filter_and_index_words(dictionary)
      dictionary.map(&:strip).select { |line|
        line.size > 3 && line.chars.all? { |c| LETTERS.include?(c) }
      }.group_by(&:length)
    end

    def generate(colorize: false)
      instance.generate(colorize: colorize)
    end
  end

  def initialize(indexed_words: load_default_indexed_words)
    @indexed_words = indexed_words
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

  def load_default_indexed_words
    YAML.load_file(File.join(__dir__, "indexed_words.yaml"))
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
