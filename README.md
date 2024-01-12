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

## Usage

Add config/initializers/qweixin.rb

```ruby

Rails.application.config.qweixin.secret = "balabala_secret"

Qweixin::Client.configure do |config|
  config.appid = ENV["WEIXIN_APPID"] # 小程序唯一凭证，即 AppID
  config.secret = ENV["WEIXIN_APPSECRET"] # 小程序唯一凭证密钥，即 AppSecret，获取方式同 appid
end

```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
