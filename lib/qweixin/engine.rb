module Qweixin
  class Engine < ::Rails::Engine
    isolate_namespace Qweixin

    initializer "qweixin", before: :load_config_initializers do |app|
      Rails.application.routes.append do
        mount Qweixin::Engine, at: "/weixin"
      end
    end

  end
end
