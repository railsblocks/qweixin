class CreateWechatUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :wechat_users do |t|
      t.string :openid, null: false
      t.string :unionid
      t.string :session_key, null: false

      t.timestamps
    end
  end
end
