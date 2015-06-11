class AddAttachmentCoverImgToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :photo
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :articles, :photo
    remove_attachment :articles, :file
  end
end
