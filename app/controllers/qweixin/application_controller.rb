module Qweixin
  class ApplicationController < ActionController::Base
    private
    def require_auth_token!
      auth_token = request.headers["Authorization"]
      token = Qweixin.encryptor.decrypt_and_verify(auth_token) rescue nil
      json_content = JSON.parse(token) rescue {}
      @current_user = User.find_by(id: json_content["user_id"])
      if @current_user.nil?
        render json: { errcode: 10000, errmsg: "user not found" } and return
      end
    end
  end
end
