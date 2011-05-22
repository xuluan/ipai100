class Message < ActiveRecord::Base
  belongs_to :user
  has_attached_file :pic, :styles => { :original => "500x500>", :medium => "100x100>", :thumb => "64x64>" }
  validates_attachment_size :pic, :less_than => 8.megabytes
  validates_attachment_content_type :pic,
  :content_type => ['image/jpeg', 'image/png', 'image/x-png', 'image/pjpeg', 'image/gif']

    validate :both_blank

    def both_blank
      errors.add(:base, "cannot be blank both of them") if context.blank? and not pic.present?
    end
end
