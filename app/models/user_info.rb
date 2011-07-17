class UserInfo < ActiveRecord::Base
  has_one :user

  has_attached_file :photo, :styles => { :original => "100x100", :medium => "64x64", :thumb => "10x10" }
  validates_attachment_size :photo, :less_than => 1.megabytes
  validates_attachment_content_type :photo,
  :content_type => ['image/jpeg', 'image/png', 'image/x-png', 'image/pjpeg', 'image/gif']
end
