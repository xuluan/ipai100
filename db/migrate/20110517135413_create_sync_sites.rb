class CreateSyncSites < ActiveRecord::Migration
  def self.up
    create_table :sync_sites do |t|
      t.integer :user_id
      t.string :site_name
      t.string :token
      t.string :secret

      t.timestamps
    end
  end

  def self.down
    drop_table :sync_sites
  end
end
