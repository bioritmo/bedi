# Bedi

![TravisCI Status](https://travis-ci.org/bioritmo/bedi.svg?branch=master)

**bedi** is a gem for parsing the many different type of EDI files out there.
It aims to provide a similar parsed interface to all of them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bedi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bedi

## Usage

```ruby
parser = Bedi::Cielo.new
result = parser.parse_file('cielo_return.txt')
# ...
parser = Bedi::Redecard.new
result = parser.parse_file('redecard_return.txt')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bioritmo/bedi.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
