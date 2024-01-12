require "test_helper"

module Qweixin
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get /weixin/app_login" do
      get "/weixin/app_login?js_code=3242343242"
      assert_response :success
    end
  end
end
