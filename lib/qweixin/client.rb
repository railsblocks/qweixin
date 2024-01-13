require "net/http"

module Qweixin
  class Client
    include ActiveSupport::Configurable

    # https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/mp-access-token/getAccessToken.html
    # 获取接口调用凭据
    # 获取小程序全局唯一后台接口调用凭据，token有效期为7200s，开发者需要进行妥善保存。
    # 返回数据示例：
    # {
    #   "access_token":"ACCESS_TOKEN",
    #   "expires_in":7200
    # }
    def getAccessToken
      raise "Client appid/secrect is not configured!" if Client.config.appid.blank? || Client.config.secret.blank?

      api_uri = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Qweixin::Client.config.appid}&secret=#{Qweixin::Client.config.secret}")
      # https://docs.ruby-lang.org/en/master/Net/HTTP.html

      response = Net::HTTP.get(api_uri)
      JSON.parse(response)
    end

    # https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-login/code2Session.html
    # 登录凭证校验。通过 wx.login 接口获得临时登录凭证 code 后传到开发者服务器调用此接口完成登录流程。更多使用方法详见小程序登录。
    # js_code: 登录时获取的 code，可通过wx.login获取
    # 返回数据示例：
    # {
    #   "openid":"xxxxxx",
    #   "session_key":"xxxxx",
    #   "unionid":"xxxxx",
    #   "errcode":0,
    #   "errmsg":"xxxxx"
    # }
    def code2session(js_code:)
      raise "Client appid/secrect is not configured!" if Client.config.appid.blank? || Client.config.secret.blank?
      raise "js_code is required!" if js_code.blank?

      api_uri = URI("https://api.weixin.qq.com/sns/jscode2session?appid=#{Qweixin::Client.config.appid}&secret=#{Qweixin::Client.config.secret}&js_code=#{js_code}&grant_type=authorization_code")
      # https://docs.ruby-lang.org/en/master/Net/HTTP.html

      response = Net::HTTP.get(api_uri)
      # puts "weixin response: #{response}"
      JSON.parse(response) rescue {}
    end
  end
end
