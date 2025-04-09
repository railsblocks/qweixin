require "net/http"
require 'openssl'

module Qweixin
  class Client
    include ActiveSupport::Configurable
    attr_accessor :access_token

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
      response_json = JSON.parse(response) rescue {}
      self.access_token = response_json["access_token"]
      response_json
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

    # DOC: https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-login/checkSessionKey.html
    # GET https://api.weixin.qq.com/wxa/checksession?access_token=ACCESS_TOKEN
    def checksession(access_token:)
      raise "access_token is required!" if access_token.blank?

      api_uri = URI("https://api.weixin.qq.com/wxa/checksession?access_token=#{access_token}")
      # https://docs.ruby-lang.org/en/master/Net/HTTP.html

      response = Net::HTTP.get(api_uri)
      # puts "weixin response: #{response}"
      JSON.parse(response) rescue {}
    end

    # 官方文档：https://pay.weixin.qq.com/doc/v3/merchant/4012791856
    # JSAPI/小程序下单
    # JSAPI支付场景(微信内置浏览器打开的网页)或小程序支付场景，商户需调用该接口在微信支付下单，生成用于调起支付的预支付交易会话标识(prepay_id)。
    def v3_pay_transaction_jsapi_encrypt()

    end

    # 官方文档：https://pay.weixin.qq.com/doc/v3/merchant/4012365342
    # 构建 APIv3 签名
    def build_request_signature(http_method_type, url, timestamp, nonce, request_body, key_pem_file)
      http_method_type = http_method_type.upcase
      ts = timestamp || Time.now.to_i # 当前时间戳
      nonce_str = nonce || SecureRandom.hex(16) # 随机字符串
      string_to_sign = "#{http_method_type}\n#{url}\n#{ts}\n#{nonce_str}\n#{request_body}\n"
      # 将字符串进行 SHA256 with RSA签名
      key_pem_file_path = key_pem_file
      private_key = OpenSSL::PKey::RSA.new(File.read(key_pem_file))

      # 生成SHA256 with RSA签名
      signature = private_key.sign(OpenSSL::Digest::SHA256.new, string_to_sign)

      # 将哈希值进行 Base64 编码
      base64_signature = Base64.strict_encode64(signature)
      base64_signature
    end

  end
end
