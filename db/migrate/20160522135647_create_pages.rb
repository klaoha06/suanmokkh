class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
    	t.string :identifier
    	t.string :title
    	t.text :content
    	t.string :url

    	t.boolean :draft, default: false

      t.timestamps null: false
    end
  end
end
