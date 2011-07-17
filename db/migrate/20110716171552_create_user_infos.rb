class CreateUserInfos < ActiveRecord::Migration
  def self.up
    create_table :user_infos do |t|
      t.string :nickname
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :user_infos
  end
end
