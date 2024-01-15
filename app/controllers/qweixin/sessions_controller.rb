module Qweixin
  class SessionsController < ApplicationController

    # 小程序登录
    # https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-login/code2Session.html
    # 登录凭证校验。通过 wx.login 接口获得临时登录凭证 code 后传到开发者服务器调用此接口完成登录流程。更多使用方法详见小程序登录。
    # https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/login.html
    # GET /weixin/app_login?code=SOME_CODE
    def code2session
      client = Client.new
      api_response = client.code2session(js_code: params[:code])
      # puts 'result: ', api_response.inspect
      if api_response.fetch("errcode", 0) != 0
        render json: api_response.slice("errcode", "errmsg")
      else
        user = User.find_or_create_by(openid: api_response["openid"]) do |user|
          user.session_key = api_response["session_key"]
          user.unionid = api_response["unionid"]
          user.last_appid = Client.config.appid
        end
        token = user.generate_auth_token
        render json: { token: token, errcode: 0, errmsg: "ok" }
      end
    end

    # 检验小程序登录态
    # https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-login/checkSessionKey.html
    # 校验服务器所保存的登录态 session_key 是否合法
    # GET /weixin/app_checksession?token=xxxxxxxxxxxxxxxxxxxxxx
    # token参数来自小程序端用户的本地缓存中，它最初是由 /weixin/app_login?code=SOME_CODE 接口登录成功后返回的
    def checksession
      json_content = Qweixin.encryptor.decrypt_and_verify(params[:token]) rescue nil
      json_content = JSON.parse(json_content) rescue {}
      if json_content.blank?
        render json: {"errcode": 87009, "errmsg": "invalid signature"} and return
      end

      user = User.find_by(id: json_content["user_id"])
      if user
        client = Client.new
        api_response = client.checksession(user.openid)
        render json: { errcode: 0, errmsg: "ok" }
      else
        render json: { errcode: 87014, errmsg: "token expired" }
      end
    end

  end
end
