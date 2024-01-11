class CreateQweixinUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :qweixin_users do |t|
      t.string :session_key
      t.string :unionid
      t.string :openid
      t.string :last_appid

      t.timestamps
    end
  end
end
