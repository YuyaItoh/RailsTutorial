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
end
