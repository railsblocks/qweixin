module Qweixin
  class User < ApplicationRecord

    def generate_auth_token
      json_content = { user_id: self.id, login_at: Time.current.to_i }
      Qweixin.encryptor.encrypt_and_sign(json_content.to_json)
    end
  end
end
