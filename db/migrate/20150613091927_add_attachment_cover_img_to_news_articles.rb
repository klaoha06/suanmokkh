class AddAttachmentCoverImgToNewsArticles < ActiveRecord::Migration
  def self.up
    change_table :news_articles do |t|
      t.attachment :cover_img
    end
  end

  def self.down
    remove_attachment :news_articles, :cover_img
  end
end
