require 'rails_helper'

RSpec.describe Favorite, type: :model do

  it {should belong_to(:user)}
  it {should belong_to(:post)}

  it "require user_id and post_id" do
    favorite = Favorite.new
    favorite_valid = favorite.valid?
    expect(favorite_valid).to eq(false)
  end
  it "unique post_id under user_id" do
    user = User.create(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                       password: "hello", password_confirmation: "hello")
    post = Post.create(title: "hello", body: "hello", user_id: user.id)
    favorite = Favorite.create(user_id: user.id, post_id: post.id)
    favorite_1 = Favorite.create(user_id: user.id, post_id: post.id)
    favorite_1.valid?
    expect(favorite_1.valid?).to eq(false)
  end
end
