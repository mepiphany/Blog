require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
      it "renders new page" do
        get :new
        expect(response).to render_template(:new)
      end
      it "instantiates new object to @new" do
        user = User.create(first_name: "michael", last_name: "lee", email: "mike@mike.com",
                           password: "hello", password_confirmation: "hello")
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
    end

  describe "#create" do
    context "with valid attritubtes" do
      def valid_request
        post :create, user: {first_name: "michael", last_name: "lee", email: "mike@mike.com",
                           password: "hello", password_confirmation: "hello"}
      end
      it "creates record in the database" do
        user_count_before = User.count
        valid_request
        user_count_after = User.count
        expect(user_count_after - user_count_before).to eq(1)
      end
      it "redirects to root_path" do
        valid_request
        expect(response).to redirect_to(root_path)
      end
      it "displays a notice" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      def invalid_request
        post :create, user: {first_name: "", last_name: "lee", email: "mike@mike.com",
                           password: "hello", password_confirmation: "hello"}
      end
      it "does not create record in the databse" do
        user_count_before = User.count
        invalid_request
        user_count_after = User.count
        expect(user_count_before - user_count_after).to eq(0)
      end
      it "renders new page" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "displays a notice" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#edit" do
    let(:user) {User.create(first_name: "mike", last_name: "lee", email: "mike@mike.com",
                       password: "hello", password_confirmation: "hello")}

    it "render edit template" do
      get :edit, id: user.id
      expect(response).to render_template(:edit)
  end
    it "finds user by it's id and sets it to @user instance variable" do
      get :edit, id: user.id
      expect(assigns[:user]).to eq(user)
    end
  end

  describe "#update" do
    context "with valid attributes" do
      let(:user) {User.create(first_name: "mike", last_name: "lee", email: "mike@mike.com",
                         password: "hello", password_confirmation: "hello")}

      it "updates new first_name" do
        patch :update, id: user.id, user: {first_name: "new_mike"}
        expect(user.reload.first_name).to eq("new_mike")
      end
      it "updates new last_name" do
        patch :update, id: user.id, user: {last_name: "new_lee"}
        expect(user.reload.last_name).to eq("new_lee")
      end
      it "updates new email" do
        patch :update, id: user.id, user: {email: "new_mike@mike.com"}
        expect(user.reload.email).to eq("new_mike@mike.com")
      end
      it "redirect_to root_path" do
        patch :update, id: user.id, user: {last_name: "new_lee"}
        expect(response).to redirect_to(root_path)
      end
      it "displays flash notice" do
        patch :update, id: user.id, user: {last_name: "new_lee"}
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      let(:user) {User.create(first_name: "mike", last_name: "lee", email: "mike@mike.com",
                         password: "hello", password_confirmation: "hello")}
      it "does not update first_name" do
        patch :update, id: user.id, user: {last_name: ""}
        expect(user.reload.last_name).to eq("lee")
      end
      it "re-renders edit page" do
        patch :update, id: user.id, user: {last_name: ""}
        expect(response).to render_template(:edit)
      end
      it "displays flash alert" do
        patch :update, id: user.id, user: {last_name: ""}
        expect(flash[:alert]).to be
      end
    end
  end
end
