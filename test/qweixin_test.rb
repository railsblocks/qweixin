require "test_helper"

class QweixinTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Qweixin::VERSION
  end

  test "it has encryptor" do
    assert Qweixin.encryptor
    assert_instance_of ActiveSupport::MessageEncryptor, Qweixin.encryptor
  end

  test "it has engine config options" do
    assert_instance_of ActiveSupport::OrderedOptions, Rails.application.config.qweixin
    assert Rails.application.config.qweixin.mount_path
    assert Rails.application.config.qweixin.secret
  end

end
