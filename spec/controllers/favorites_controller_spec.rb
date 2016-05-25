require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) {User.create(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                     password: "hello", password_confirmation: "hello")}

  describe "#index" do
    before {signin(user)}
    it "rendered index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "shows favored posts of a current_user" do
      post = Post.create(title: "hello", body: "hello", user_id: user.id)
      favorite = Favorite.create(user_id: user.id, post_id: post.id)
      post_1 = Post.create(title: "hello_1", body: "hello_1", user_id: user.id)
      favorite_1 = Favorite.create(user_id: user.id, post_id: post_1.id)
      get :index
      expect(assigns(:posts)).to eq([post, post_1])
    end
  end

  describe "#create" do
    before {signin(user)}
    context "with valid request" do
      def valid_request
        binding.pry
      end
      it "creates a record in the database" do
        favorite_count_before = Favorite.count
        valid_request
        favorite_count_after = Favorite.count

        expect(favorite_count_after - favorite_count_before).to eq(1)
      end
    end
    context "with invalid request" do

    end
  end
end
