class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|

    	t.references :user
    	t.string :name

    	t.timestamps null: false
    end
  end
end
