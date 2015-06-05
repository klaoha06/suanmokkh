class AddAttachmentPhotoToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :cover_img
    end
  end

  def self.down
    remove_attachment :books, :cover_img
  end
end
