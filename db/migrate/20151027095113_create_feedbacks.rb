class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :title
      t.text :content
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :tel
      t.boolean :required_response, default: false
      t.boolean :responsed, default: false

      t.timestamps null: false
    end
  end
end
