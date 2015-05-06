# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :sring
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

# == association
  has_many :microposts, dependent: :destroy

# == validation
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # セキュアなパスワードの実装を行う便利メソッド
  has_secure_password
  validates :password, length: { minimum: 6 }

  # フィードを取得？
  def feed
    # このコードは準備段階です
    # 完全な実装は11章
    Micropost.where("user_id=?", id)
  end

  # 暗号化する前のトークン
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private 
    # 暗号化したトークン
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
