class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
    	t.string :title
    	t.text :content
    	t.string :author
      t.string :language
      t.string :series
      t.string :group
      t.date :creation_date

      t.integer :views

      t.boolean :draft, default: false
      t.boolean :featured, default: false
      t.boolean :allow_comments, default: true

      t.timestamps null: false
    end
  end
end
