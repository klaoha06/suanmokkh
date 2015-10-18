class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :book_id
      t.integer :related_book_id

      t.timestamps null: false
    end
  end
end
