class AddAttachmentMobiToEbooks < ActiveRecord::Migration
  def self.up
    change_table :ebooks do |t|
      t.attachment :mobi
    end
  end

  def self.down
    remove_attachment :ebooks, :mobi
  end
end
