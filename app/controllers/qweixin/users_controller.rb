module Qweixin
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :require_auth_token!, only: %i[ show ]

    # GET /weixin/user
    def show
      render json: { errcode: 0, errmsg: "ok", user_info: @current_user.as_json(only: %i[ id nickname mobile avatar ]) }
    end
  end
end
