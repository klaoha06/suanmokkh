class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
    	t.string :title
    	t.text :content
    	# t.string :language
    	t.string :series
    	# t.string :group
    	
    	# t.string :publisher
    	t.date :publication_date

    	t.boolean :draft, default: false
    	t.boolean :featured, default: false
    	t.boolean :allow_comments, default: true
    	t.integer :reads, default: 0

    	# t.belongs_to :publisher, index:true

      t.timestamps null: false
    end
  end
end
