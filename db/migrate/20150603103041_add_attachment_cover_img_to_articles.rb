class AddAttachmentCoverImgToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :cover_img
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :articles, :cover_img
    remove_attachment :articles, :file
  end
end
