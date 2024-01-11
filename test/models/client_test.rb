require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "it has a config item: appid" do
    assert Qweixin::Client.config.appid
  end

  test "it has a config item: secret" do
    assert Qweixin::Client.config.secret
  end

end
