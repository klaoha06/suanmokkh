class AddAttachmentCoverImgToRetreatTalks < ActiveRecord::Migration
  def self.up
    change_table :retreat_talks do |t|
      t.attachment :cover_img
    end
  end

  def self.down
    remove_attachment :retreat_talks, :cover_img
  end
end
