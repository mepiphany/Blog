require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) {User.create!(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                     password: "hello", password_confirmation: "hello")}
  let!(:user_1) {User.create!(first_name: "mike", last_name: "lee", email: "mike1@mike.com",
                     password: "hello", password_confirmation: "hello")}
  let!(:post_1) {Post.create!(title: "hello", body: "this is", user_id: user_1.id)}


  describe "#new" do
    before {signin(user)}
    it "renders new post page" do
      get :new
      expect(response).to render_template(:new)
    end
    it "instantiates new object to a @new instance variable" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "displays all posts" do
      post_1 = Post.create(title: "hello", body: "this is")
      post_2 = Post.create(title: "hello1", body: "this is1")
      get :index
      expect(assigns(:posts)).to eq([post_1, post_2])
    end
  end

  describe "#create" do
    before {signin(user)}
    context "valid attributes" do
      def valid_request
        post :create, post: {title: "hello", body: "hello"}
      end
      it "creates record in the database" do
        post_count_before = Post.count
        valid_request
        post_count_after = Post.count
        expect(post_count_after - post_count_before).to eq(1)
      end
      it "redirect to the post show page" do
        valid_request
        post = Post.last
        expect(response).to redirect_to(post_path(post))
      end
      it "displays notice" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "invalid attributes"
      def invalid_request
        post :create, post: {title: "", body: "hello"}
      end
      it "does not create record in the databse" do
        post_count_before = Post.count
        invalid_request
        post_count_after = Post.count
        expect(post_count_after - post_count_before).to eq(0)
      end
      it "re-renders new page" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "displays alert" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end

  describe "#show" do
    it "renders the show page" do
      post = Post.create(title: "hello", body: "hello", user_id: user.id)
      get :show, id: post.id
      expect(response).to render_template(:show)
    end
    it "finds the id and save saves it to @post variable" do
      post = Post.create(title: "hello", body: "hello", user_id: user.id)
      get :show, id: post.id
      expect(assigns(:post)).to eq(post)
    end
    it "raises an error if the id passed doesn't match the record in the DB" do
      post = Post.create(title: "hello", body: "hello", user_id: user.id)
      get :show, id: post.id
      expect {get:show, id: 12312312}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#edit" do
    before{signin(user)}
    it "renders edit page" do
      post = Post.create(title: "hello", body: "hello", user_id: user.id)
      get :edit, id: post.id
      expect(response).to render_template(:edit)
    end
    it "finds the post with an id and sets it to @post instance variable" do
      post = Post.create(title: "hello", body: "hello", user_id: user.id)
      get :edit, id: post.id
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "#update" do
    before{signin(user)}
    context "with valid attributes" do
      it "updates to new a record" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        patch :update, id: post.id, post: {title: "new_title", body: "new_body"}
        expect(post.reload.title).to eq("new_title")
      end
      it "redirect_to post show page" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        patch :update, id: post.id, post: {title: "new_title", body: "new_body"}
        expect(response).to redirect_to(post_path(post.reload))
      end
      it "displays flash notice" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        patch :update, id: post.id, post: {title: "new_title", body: "new_body"}
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      it "does not update to a record" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        patch :update, id: post.id, post: {title: "", body: "new_body"}
        expect(post.reload.title).to eq("title")
      end
      it "re-renders the page" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        patch :update, id: post.id, post: {title: "", body: "new_body"}
        expect(response).to render_template(:edit)
      end
      it "displays flash alert" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        patch :update, id: post.id, post: {title: "", body: "new_body"}
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    context "authorize user" do
      before{signin(user)}
      it "destroys the post record in the DB" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        post_count_before = Post.count
        delete :destroy, id: post.id
        post_count_after = Post.count
        expect(post_count_after - post_count_before).to eq(-1)
      end
      it "redirect to a homepage" do
        post = Post.create(title: "title", body: "body", user_id: user.id)
        delete :destroy, id: post.id
        expect(response).to redirect_to(posts_path)
      end
    end
  end
end
