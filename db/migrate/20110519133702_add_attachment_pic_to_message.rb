class AddAttachmentPicToMessage < ActiveRecord::Migration
  def self.up

    add_column :messages, :pic_file_name, :string
    add_column :messages, :pic_content_type, :string
    add_column :messages, :pic_file_size, :integer
    add_column :messages, :pic_updated_at, :datetime

  end

  def self.down

    remove_column :messages, :pic_file_name
    remove_column :messages, :pic_content_type
    remove_column :messages, :pic_file_size
    remove_column :messages, :pic_updated_at

  end
end
