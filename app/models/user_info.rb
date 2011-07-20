class UserInfo < ActiveRecord::Base
  has_one :user


  has_attached_file :photo, :styles => { :original => "100x100", :medium => "64x64", :thumb => "10x10" }
  validates_attachment_size :photo, :less_than => 1.megabytes
  validates_attachment_content_type :photo,
  :content_type => ['image/jpeg', 'image/png', 'image/x-png', 'image/pjpeg', 'image/gif']

  def get_followers(limit = 10, offset = 0)
    UserInfo.find(:all,
      :joins => "inner join user_follows as f on f.following_id = #{self.id} and user_infos.id = f.follower_id",
      :limit => limit,
      :offset => offset
      )
  end


  def get_followings(limit = 10, offset = 0)
    UserInfo.find(:all,
      :joins => "inner join user_follows as f on f.follower_id = #{self.id} and user_infos.id = f.following_id",
      :limit => limit,
      :offset => offset
      )
  end

  def add_follow(id)
    UserFollow.create(:follower_id => id, :following_id => self.id) if UserFollow.where(
        "follower_id = #{id} and following_id = #{self.id}").size == 0
  end

  def del_follow(id)
    UserFollow.delete_all("follower_id = #{id} and following_id = #{self.id}")
  end

end
