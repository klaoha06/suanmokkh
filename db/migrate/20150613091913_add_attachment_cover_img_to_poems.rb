class AddAttachmentCoverImgToPoems < ActiveRecord::Migration
  def self.up
    change_table :poems do |t|
      t.attachment :cover_img
    end
  end

  def self.down
    remove_attachment :poems, :cover_img
  end
end
