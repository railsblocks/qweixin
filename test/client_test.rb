require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "it has a config item: appid" do
    assert Qweixin::Client.config.appid
  end

  test "it has a config item: secret" do
    assert Qweixin::Client.config.secret
  end

  test "it should get access token from weixin server" do
    client = Qweixin::Client.new
    result_json = client.getAccessToken
    assert result_json["access_token"]
    assert result_json["expires_in"]
  end

  test "it should get invalid response when request weixin app login" do
    client = Qweixin::Client.new
    invalid_js_code = "24334233"
    result_json = client.code2session(js_code: invalid_js_code)
    # {"errcode"=>40029, "errmsg"=>"invalid code, rid: 65a13fa1-50a5ffef-30645fdc"}
    # keys: ["errcode", "errmsg"] ???
    assert result_json["errcode"]
    assert result_json["errmsg"]
    # assert result_json[:rid] #### This is invalid
  end

end
