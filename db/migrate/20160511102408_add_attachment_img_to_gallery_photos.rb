class AddAttachmentImgToGalleryPhotos < ActiveRecord::Migration
  def self.up
    change_table :gallery_photos do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :gallery_photos, :img
  end
end
