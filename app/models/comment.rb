# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text
#

class Comment < ActiveRecord::Base
  belongs_to :post

  belongs_to :user
  # after_save :organize_by_recent_date

  validates :body, presence: true, uniqueness: { scope: :post_id }

  scope :by_most_recent, -> { order(created_at: :desc) }

  # def self.organize_by_recent_date
  #   order(created_at: :desc)
  # end
end
