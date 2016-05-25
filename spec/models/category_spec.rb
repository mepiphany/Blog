require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validates" do
    it "require title" do
      category = Category.new
      category_valid = category.valid?
      expect(category_valid).to eq(false)
    end
    it "needs to be unique" do
      category = Category.create(name: "science")
      category_1 = Category.create(name: "science")
      category_1_valid = category_1.valid?
      expect(category_1_valid).to eq(false)
    end
    describe Category do
      it {should have_many(:posts)}
    end
  end
end
