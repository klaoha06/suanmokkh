class AddAttachmentEpubToEbooks < ActiveRecord::Migration
  def self.up
    change_table :ebooks do |t|
      t.attachment :epub
    end
  end

  def self.down
    remove_attachment :ebooks, :epub
  end
end
