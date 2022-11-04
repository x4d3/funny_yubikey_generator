# frozen_string_literal: true

require "singleton"
require "colorize"
require "set"
class YubikeyGenerator
  VERSION = "0.1.0"

  include Singleton
  COLORS = %i[red green yellow blue magenta cyan]

  def initialize(dictionary: nil, letters: "cbdefghijklnrtuv".chars.to_set)
    input = dictionary || File.open(File.join(__dir__, "words.txt"))
    @dictionary = input.map(&:strip).select { |line|
      line.chars.all? do |c|
        letters.include?(c)
      end
    }.group_by(&:length)
  end

  def generate(size: 40, colorize: true)
    sizes = @dictionary.keys - [1, 2, 3]
    words = []
    while size > 0
      word_size = sizes.filter { |s| s <= size && (size - s) > 3 }.sample
      unless word_size
        words << @dictionary[size].sample
        break
      end
      words << @dictionary[word_size].sample
      size -= word_size
    end
    if colorize
      words.map!.with_index { |w, i| w.colorize(COLORS[i % COLORS.length]) }
    end

    "/cccc" + words.join
  end

  class << self
    def generate(size: 40, colorize: true)
      instance.generate(size: size, colorize: colorize)
    end
  end
end
