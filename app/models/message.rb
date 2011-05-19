class Message < ActiveRecord::Base
  belongs_to :user
  has_attached_file :pic, :styles => { :original => "500x500>", :medium => "100x100>", :thumb => "64x64>" }
  validates_attachment_size :pic, :less_than => 8.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png']
end
