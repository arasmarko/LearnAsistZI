class CreateResourceFormats < ActiveRecord::Migration
  def change
    create_table :resource_formats do |t|

    	t.string :name

      t.timestamps null: false
    end
  end
end
