require "application_system_test_case"

module Qweixin
  class UsersTest < ApplicationSystemTestCase
    setup do
      @user = qweixin_users(:one)
    end

    test "visiting the index" do
      visit users_url
      assert_selector "h1", text: "Users"
    end

    test "should create user" do
      visit users_url
      click_on "New user"

      fill_in "Last appid", with: @user.last_appid
      fill_in "Openid", with: @user.openid
      fill_in "Session key", with: @user.session_key
      fill_in "Unionid", with: @user.unionid
      click_on "Create User"

      assert_text "User was successfully created"
      click_on "Back"
    end

    test "should update User" do
      visit user_url(@user)
      click_on "Edit this user", match: :first

      fill_in "Last appid", with: @user.last_appid
      fill_in "Openid", with: @user.openid
      fill_in "Session key", with: @user.session_key
      fill_in "Unionid", with: @user.unionid
      click_on "Update User"

      assert_text "User was successfully updated"
      click_on "Back"
    end

    test "should destroy User" do
      visit user_url(@user)
      click_on "Destroy this user", match: :first

      assert_text "User was successfully destroyed"
    end
  end
end
