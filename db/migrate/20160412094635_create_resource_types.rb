class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|

    	t.string :name

      t.timestamps null: false
    end
  end
end
