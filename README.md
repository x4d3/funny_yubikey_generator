# FunnyYubikeyGenerator

[![Ruby CI](https://github.com/x4d3/funny_yubikey_generator/actions/workflows/main.yml/badge.svg)](https://github.com/x4d3/funny_yubikey_generator/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/funny_yubikey_generator.svg)](https://badge.fury.io/rb/funny_yubikey_generator)



Generate funny looking [yubikey OTP](https://developers.yubico.com/OTP/OTPs_Explained.html) containing words based on a dictionary.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add funny_yubikey_generator

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install funny_yubikey_generator

## Usage
    
As CLI:
```bash
gem install funny_yubikey_generator
generate_funny_yubikey -c
```

![preview.png](preview.png)

In Ruby:
```ruby
require "funny_yubikey_generator"
puts FunnyYubikeyGenerator.generate(colorize: true)

dictionary = <<~DICO
      crude
      blubber
      futile
      lutrin
      interbelligerent
      reinterference
DICO
generator = FunnyYubikeyGenerator.from_dictionary(dictionary)
puts generator.generate(colorize: true)

generator = FunnyYubikeyGenerator.from_dictionary(File.read("/usr/share/dict/words"))
puts generator.generate(colorize: false)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the `spec.version` in [funny_yubikey_generator.gemspec](funny_yubikey_generator.gemspec), and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/x4d3/funny_yubikey_generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/x4d3/funny_yubikey_generator/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FunnyYubikeyGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/x4d3/funny_yubikey_generator/blob/master/CODE_OF_CONDUCT.md).
