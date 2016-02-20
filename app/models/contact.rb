# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ActiveRecord::Base
  validates :email, confirmation: true

  validates :name, length: { minimum: 2 }

  validates :subject, presence: true

  validates :message, length: { minimum: 5,
                                maximum: 300      
                                    }
end
