class AddUserInfoId < ActiveRecord::Migration
  def self.up
    add_column :users, :user_info_id, :integer

  end

  def self.down
    remove_column :users, :user_info_id, :integer
  end
end
