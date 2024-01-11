Qweixin::Client.configure do |config|
  config.appid = ENV["WEIXIN_APPID"] # 小程序唯一凭证，即 AppID，可在「微信公众平台 - 设置 - 开发设置」页中获得。（需要已经成为开发者，且帐号没有异常状态）
  config.secret = ENV["WEIXIN_APPSECRET"] # 小程序唯一凭证密钥，即 AppSecret，获取方式同 appid
end
