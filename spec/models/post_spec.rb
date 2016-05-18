require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "validations" do
    it "require a title" do
      post = Post.new
      post.valid?
      expect(post.errors).to have_key(:title)
    end
    it "require a unique title" do
      post = Post.create(title: "hello", body: "hello")
      post_1 = Post.create(title: "hello", body: "hello")
      post_1.valid?
      expect(post_1.errors).to have_key(:title)
    end
    it "require a title with minimim length of 3 characters" do
      post = Post.create(title: "hi")
      post.valid?
      expect(post.errors).to have_key(:title)
    end
    it "require a title with maximum length of 20 characters" do
      post = Post.create(title: "alsdkjflaksdjflkjsadflkjsadlkfj")
      post.valid?
      expect(post.errors).to have_key(:title)
    end
    it "require a body with minimim length of 3 characters" do
      post = Post.create(title: "hello", body: "he")
      post.valid?
      expect(post.errors).to have_key(:body)
    end
  end
end
