class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|

    	t.references :step
    	t.references :resource_type
    	t.references :resource_format
    	t.string :name
    	t.string :url
    	t.string :path

      t.timestamps null: false
    end
  end
end
