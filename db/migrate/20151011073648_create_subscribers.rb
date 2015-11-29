class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
    	t.string :username
    	t.string :email

      t.timestamps null: false
    end
  end
end
