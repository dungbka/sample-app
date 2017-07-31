class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_content}
  validate :picture_size

  scope :order_desc, ->{order created_at: :DESC}

  def picture_size
    return unless picture.size > Settings.picture_size.megabytes
    errors.add :picture, t("micropost.less_5mb")
  end
end
