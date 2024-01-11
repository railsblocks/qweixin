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

end
