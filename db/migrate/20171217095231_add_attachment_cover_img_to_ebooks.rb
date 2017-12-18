class AddAttachmentCoverImgToEbooks < ActiveRecord::Migration
  def self.up
    change_table :ebooks do |t|
      t.attachment :cover_img
    end
  end

  def self.down
    remove_attachment :ebooks, :cover_img
  end
end
