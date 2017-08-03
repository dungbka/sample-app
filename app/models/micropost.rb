class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_content}
  validate :picture_size

  scope :order_desc, ->{order created_at: :DESC}
  microposts_feed = lambda do |user|
    where user_id: user.following_ids << user.id
  end
  scope :microposts_feed, microposts_feed

  def picture_size
    return unless picture.size > Settings.picture_size.megabytes
    errors.add :picture, t("micropost.less_5mb")
  end
end
