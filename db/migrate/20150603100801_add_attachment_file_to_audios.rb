class AddAttachmentFileToAudios < ActiveRecord::Migration
  def self.up
    change_table :audios do |t|
      t.attachment :file
      # t.attachment :cover_img
    end
  end

  def self.down
    remove_attachment :audios, :file
    # remove_attachment :audios, :cover_img
  end
end
