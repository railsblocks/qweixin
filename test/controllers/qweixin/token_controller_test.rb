require "test_helper"

module Qweixin
  class TokenControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get getAccessToken" do
      get token_getAccessToken_url
      assert_response :success
    end
  end
end
