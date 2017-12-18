class CreateEbookCollection < ActiveRecord::Migration
  def change
    create_table :ebook_collections do |t|
    	t.integer :ebook_id
    	t.integer :related_ebook_id
    end
  end
end
