# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: [:slugged, :history]
  belongs_to :user

  has_many(:comments, {dependent: :destroy})
  belongs_to :category

  has_many :favorites, dependent: :destroy
  has_many :favored_users, through: :favorites, source: :user


  # def comments
  #   Comment.where(post_id: id)
  # end


  validates :title, presence: true,
                    uniqueness: true

  validates :body, length: { minimum: 3, maximum: 300 }

  def self.search(search)
    post_search = "%" + search + "%"
    where("title ILIKE ? OR body ILIKE ?", post_search, post_search )
  end

  def category_name
    category.name if category
  end

  def favor_for(user)
    favorites.find_by_user_id(user)
  end


 end
