require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "it has a config item: appid" do
    assert Qweixin::Client.config.appid
  end

  test "it has a config item: secret" do
    assert Qweixin::Client.config.secret
  end

  test "it should get access token from weixin server" do
    net_http_mock = Minitest::Mock.new
    mocked_response = '{"access_token":"Balaba_accesstoken","expires_in":7200}'
    mocked_arg = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Qweixin::Client.config.appid}&secret=#{Qweixin::Client.config.secret}")
    net_http_mock.expect(:call, mocked_response, [mocked_arg])

    Net::HTTP.stub(:get, net_http_mock) do
      client = Qweixin::Client.new
      result_json = client.getAccessToken
      assert result_json["access_token"]
      assert result_json["expires_in"]
      assert_equal "Balaba_accesstoken", result_json["access_token"]
      assert_equal 7200, result_json["expires_in"]
    end
  end

  test "it should get invalid response when request weixin app login" do
    invalid_js_code = "24334233"

    net_http_mock = Minitest::Mock.new
    # mocked_response = '{"errcode":40029, "errmsg":"invalid code, rid: 65a13fa1-50a5ffef-30645fdc"}'
    mocked_response = '{"errcode":40013,"errmsg":"invalid appid, rid: 65a29241-17ce7fe3-0b4c522b"}'
    mocked_arg = URI("https://api.weixin.qq.com/sns/jscode2session?appid=#{Qweixin::Client.config.appid}&secret=#{Qweixin::Client.config.secret}&js_code=#{invalid_js_code}&grant_type=authorization_code")
    net_http_mock.expect(:call, mocked_response, [mocked_arg])

    Net::HTTP.stub(:get, net_http_mock) do
      client = Qweixin::Client.new

      result_json = client.code2session(js_code: invalid_js_code)
      assert result_json["errcode"]
      assert result_json["errmsg"]
    end
  end

end
