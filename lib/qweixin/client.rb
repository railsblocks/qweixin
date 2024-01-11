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
  end
end
