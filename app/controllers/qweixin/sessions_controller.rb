module Qweixin
  class SessionsController < ApplicationController

    # 小程序登录
    # https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-login/code2Session.html
    # 登录凭证校验。通过 wx.login 接口获得临时登录凭证 code 后传到开发者服务器调用此接口完成登录流程。更多使用方法详见小程序登录。
    # https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/login.html
    # GET /weixin/app_login
    def jscode2session
      client = Client.new
      result = client.code2session(js_code: params[:js_code])
      puts 'result: ', result.inspect

      User.find_or_create_by(openid: result["openid"]) do |user|
        user.session_key = result["session_key"]
        user.unionid = result["unionid"]
        user.last_appid = Client.config.appid
      end

      render json: result
    end

  end
end
