# frozen_string_literal: true

require_relative "lib/yubikey_generator"

Gem::Specification.new do |spec|
  spec.name = "yubikey_generator"
  spec.version = YubikeyGenerator::VERSION
  spec.authors = ["Xavier Delamotte"]
  spec.email = ["xavier.delamotte@shopify.com"]

  spec.summary = "Generates fun yubikeys"
  spec.description = "Generates fun yubikeys"
  spec.homepage = "https://github.com/x4d3/yubikey_generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "colorize", "~> 0.8.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
