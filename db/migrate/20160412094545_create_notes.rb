class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|

    	t.references :step
    	t.string :name
    	t.string :note

      t.timestamps null: false
    end
  end
end
