class AddAttachmentPdfToEbooks < ActiveRecord::Migration
  def self.up
    change_table :ebooks do |t|
      t.attachment :pdf
    end
  end

  def self.down
    remove_attachment :ebooks, :pdf
  end
end
