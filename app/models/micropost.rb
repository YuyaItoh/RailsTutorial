# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }, presence: true

  def self.from_users_followed_by(user)
    # フォローしているユーザ一覧を取得するとフォロー数が莫大になった時に非効率
    # followed_user_ids = user.followed_user_ids

    # サブセレクトでメモリに展開せずにDB無いで保存する
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"

    # Micropost.where()の省略
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end
end
