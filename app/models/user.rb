class User < ActiveRecord::Base
  has_secure_password

  attr_accessor :current_password

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :password, presence: true, if: :changing_password?

  validates :password_confirmation, presence: true, if: :changing_password?


  private

  def changing_password?
    current_password.present?
  end
end
