require "test_helper"

module Qweixin
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should login success /weixin/app_login with valid code" do
      valid_code = "AAAABBCCCCMDpR1Qnl111rS1rY3C5i1c"
      net_http_mock = Minitest::Mock.new
      mocked_response = '{"session_key":"AAASrAB+K5Y1u44y4jNsjQ==","openid":"#{SecureRandom.hex}"}'
      mocked_arg = URI("https://api.weixin.qq.com/sns/jscode2session?appid=#{Qweixin::Client.config.appid}&secret=#{Qweixin::Client.config.secret}&js_code=#{valid_code}&grant_type=authorization_code")
      net_http_mock.expect(:call, mocked_response, [mocked_arg])

      Net::HTTP.stub(:get, net_http_mock) do
        assert_difference 'User.count' do
          get "/weixin/app_login?code=#{valid_code}"
          assert_response :success

          assert_equal "application/json; charset=utf-8", response.content_type
          response_body = JSON.parse(response.body)
          assert response_body["token"]
          assert_equal 0, response_body["errcode"]
          assert_equal "ok", response_body["errmsg"]
        end
      end
    end

    test "should login success /weixin/app_login with invalid code" do
      invalid_code = "00000000000000000000000000000000"
      assert_no_changes "User.count" do
        get "/weixin/app_login?code=#{invalid_code}"
        assert_response :success
        assert_equal "application/json; charset=utf-8", response.content_type
        response_body = JSON.parse(response.body)

        assert_not_equal 0, response_body["errcode"]
        assert_not_equal "ok", response_body["errmsg"]
      end
    end
  end
end
