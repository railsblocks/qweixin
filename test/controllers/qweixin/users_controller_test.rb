require "test_helper"

module Qweixin
  class UsersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @user = qweixin_users(:one)
    end

    test "should get not user json without auth token" do
      get user_url
      assert_response :success
      assert_equal "{\"errcode\":10000,\"errmsg\":\"user not found\"}", response.body
    end

    test "should get not user json after app login" do
      valid_code = "AAAABBCCCCMDpR1Qnl111rS1rY3C5i1c"
      net_http_mock = Minitest::Mock.new
      mocked_response = '{"session_key":"AAASrAB+K5Y1u44y4jNsjQ==","openid":"#{SecureRandom.hex}"}'
      mocked_arg = URI("https://api.weixin.qq.com/sns/jscode2session?appid=#{Qweixin::Client.config.appid}&secret=#{Qweixin::Client.config.secret}&js_code=#{valid_code}&grant_type=authorization_code")
      net_http_mock.expect(:call, mocked_response, [mocked_arg])

      Net::HTTP.stub(:get, net_http_mock) do
        # send request with auth token in header
        get "/weixin/app_login?code=#{valid_code}"
        assert_response :success

        # get user_url request, with auth token in header
        token = User.last.generate_auth_token
        get user_url, headers: { 'Authorization' => token }
        result_json = JSON.parse(response.body)
        assert_equal ["errcode", "errmsg", "user_info"], result_json.keys
        assert_equal ["id", "nickname", "mobile", "avatar"], result_json["user_info"].keys
      end

    end


  end
end
