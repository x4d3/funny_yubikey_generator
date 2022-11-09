# frozen_string_literal: true

require "funny_yubikey_generator"
require "bundler/gem_tasks"
require "rake/testtask"
require "yaml"
require "standard/rake"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

# rake "filter_words[lib/words.txt]" > lib/words2.txt
task :filter_words, [:path] do |_, args|
  puts FunnyYubikeyGenerator.filter_words(File.read(args[:path])).join("\n")
end

task default: %i[test standard]
