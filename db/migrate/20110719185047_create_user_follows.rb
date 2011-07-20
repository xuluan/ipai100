class CreateUserFollows < ActiveRecord::Migration
  def self.up
    create_table :user_follows do |t|
      t.integer :follower_id, :null => false
      t.integer :following_id, :null => false

    end

    add_index :user_follows, :follower_id
    add_index :user_follows, :following_id
  end

  def self.down
    drop_table :user_follows
  end
end
