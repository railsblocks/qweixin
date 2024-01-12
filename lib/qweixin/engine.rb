module Qweixin
  class Engine < ::Rails::Engine
    isolate_namespace Qweixin

    config.qweixin = ActiveSupport::OrderedOptions.new
    config.qweixin.secret = nil
    config.qweixin.mount_path = "/weixin"

    initializer "qweixin", before: :load_config_initializers do |app|
      Rails.application.routes.append do
        mount Qweixin::Engine, at: app.config.qweixin.mount_path
      end

      config.after_initialize do |app|
        Qweixin.encryptor = ActiveSupport::MessageEncryptor.new(app.config.qweixin.secret)
      end

    end

  end
end
