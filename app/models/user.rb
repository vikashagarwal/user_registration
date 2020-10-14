class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  attr_accessor :profile_picture_file_name, :profile_picture_content_type, :profile_picture_file_size
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" },
    url: ":rails_root/public/images/profile_picture/:id/:style.:extension",
    path: ":rails_root/public/images/profile_picture/:id/:style.:extension"#, default_url: "/images/:style/missing.png" _:basename

  validates_attachment :profile_picture, presence: true, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
