module Qweixin
  class SessionsController < ApplicationController

    # 小程序登录
    # https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-login/code2Session.html
    # 登录凭证校验。通过 wx.login 接口获得临时登录凭证 code 后传到开发者服务器调用此接口完成登录流程。更多使用方法详见小程序登录。
    # https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/login.html
    # GET /weixin/app_login
    def code2session
      client = Client.new
      api_response = client.code2session(js_code: params[:code])
      # puts 'result: ', api_response.inspect
      if api_response.fetch("errcode", 0) != 0
        render json: api_response.slice("errcode", "errmsg")
      else
        # {"session_key"=>"xxxxxxxxxxxxxxxxxxxxxx==", "openid"=>"aaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
        user = User.find_or_create_by(openid: api_response["openid"]) do |user|
          user.session_key = api_response["session_key"]
          user.unionid = api_response["unionid"]
          user.last_appid = Client.config.appid
        end
        json_content = { user_id: user.id, login_at: Time.current.to_i }
        token = Qweixin.encryptor.encrypt_and_sign(json_content.to_json)
        render json: { token: token, errcode: 0, errmsg: "ok" }
      end
    end

  end
end
