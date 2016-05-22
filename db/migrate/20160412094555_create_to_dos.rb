class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|

    	t.references :step
    	t.string :name
    	t.string :note

      t.timestamps null: false
    end
  end
end
