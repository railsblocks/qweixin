# Qweixin
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "qweixin"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install qweixin
```

Add the following line to your `config/routes.rb`:

```ruby
mount Qweixin::Engine => "/qweixin" if defined?(Qweixin::Engine)
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
