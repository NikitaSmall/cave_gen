# CaveGen

A little gem to create a random caves. For your games (roguelikes or similar) or just for fun.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cave_gen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cave_gen

## Usage

It is very easy to create your own caves!

```ruby
cave = CaveGen::Cave.new(height, width, error, opacity)
cave.show_map
```
height and width is a numbers of rows and columns in your array.
error is a numbers of attempts to continue build cave from another place on map.
opacity is a number that shows curlicue of your cave. The higher number makes simpler cave.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cave_gen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
