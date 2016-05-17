require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    let!(:user) {User.new}
    it "requires first_name" do
      user.valid?
      expect(user.errors).to have_key(:first_name)
    end

    it "requires last_name" do
      user.valid?
      expect(user.errors).to have_key(:last_name)
    end

    it "requires an email" do
      user.valid?
      expect(user.errors).to have_key(:email)
    end

    it "requires password" do
      user.valid?
      expect(user.errors).to have_key(:password)
    end

    it "requires unique email" do
      user = User.create(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                         password: "hello", password_confirmation: "hello")
      user1 = User.create(first_name: "michael1", last_name: "lee1", email: "mike@mike.com",
                         password: "hello", password_confirmation: "hello")
      user1.valid?
      expect(user1.errors).to have_key(:email)
    end
  end

  describe ".full_name method" do
    it "concatenate first_name + last_name" do
      user = User.create(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                         password: "hello", password_confirmation: "hello")
      expect(user.full_name).to include("#{user.first_name.titleize} #{user.last_name.titleize}")
    end
  end

  describe "password generation" do
    it "generates password_digest" do
      user = User.create(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                         password: "hello", password_confirmation: "hello")
      expect(user.password_digest).to be
    end
  end

  describe "auto_token generation" do
    it "generates auth_token" do
      user = User.create(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                         password: "hello", password_confirmation: "hello")
      expect(user.auth_token).to be
    end
  end

end
