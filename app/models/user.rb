require 'securerandom'
class User < ActiveRecord::Base
  has_secure_password

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favored_posts, through: :favorites, source: :post

  attr_accessor :current_password

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :password, presence: true, if: :changing_password?

  validates :password_confirmation, presence: true, if: :changing_password?

  before_create { generate_token(:auth_token)}

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  private

  def changing_password?
    current_password.present?
  end
end
