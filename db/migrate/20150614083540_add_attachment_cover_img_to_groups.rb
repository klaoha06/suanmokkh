class AddAttachmentCoverImgToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.attachment :cover_img
    end
  end

  def self.down
    remove_attachment :groups, :cover_img
  end
end
