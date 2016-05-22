class AddTodosStatus < ActiveRecord::Migration
  def change
  	add_column :to_dos, :status, :text
  end
end
