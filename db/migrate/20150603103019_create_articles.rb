class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
    	t.string :title
    	t.text :content
    	t.string :language
    	t.integer :reads, default: 0
    	t.string :series
    	t.string :publisher
    	t.boolean :draft, default: false
    	t.boolean :featured, default: false
    	t.boolean :allow_comments, default: true

      t.timestamps null: false
    end
  end
end
