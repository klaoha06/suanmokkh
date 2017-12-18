class AddAttachmentEpubToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :epub
    end
  end

  def self.down
    remove_attachment :books, :epub
  end
end
