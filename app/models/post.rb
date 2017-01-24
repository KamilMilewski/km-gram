class Post < ApplicationRecord
  validates :image, presence: true
  # 640x - images are resizing ewery image to 640px wide. But there is no limit to image height.
  has_attached_file :image, styles: { medium: "640x", thumb: "100x" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
