# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "yaml"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :generate_index_words do
  puts FunnyYubikeyGenerator.filter_and_index_words(File.open("/usr/share/dict/words")).to_yaml
end

require "standard/rake"

task default: %i[test standard]
