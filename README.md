# Withings API Ruby thin client wrapper library

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'withings_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install withings_api

## Usage

```ruby
require 'withings_api'
require 'json'

# create a instance of API wrapper
t = WithingsAPI::Client.new({
  :consumer_key => 'YOUR_API_KEY',
  :consumer_secret => 'YOUR_API_SECRET',
  :token => 'YOUR_ACCESS_TOKEN',
  :token_secret => 'YOUR_ACCESS_SECRET'
})

# get weight (kg)
res = w.get_body_measures({
  'meastype' => '1'
})
puts res.headers
puts JSON.pretty_generate(JSON.parse(res.body))
```

## Documentation

Withings Api Reference
https://oauth.withings.com/api/doc

## Development

```sh
$ rake -T
rake build            # Build withings_api-X.X.X.gem into the pkg directory
rake clean            # Remove any temporary products
rake clobber          # Remove any generated files
rake install          # Build and install withings_api-X.X.X.gem into system gems
rake install:local    # Build and install withings_api-X.X.X.gem into system gems without network access
rake release[remote]  # Create tag vX.X.X and build and push withings_api-X.X.X.gem to Rubygems
rake spec             # Run RSpec code examples
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/niwasawa/withings-api-ruby-thin-client-wrapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

