class AddAttachmentMobiToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :mobi
    end
  end

  def self.down
    remove_attachment :books, :mobi
  end
end
