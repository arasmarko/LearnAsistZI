class AddAttachmentAssetToResources < ActiveRecord::Migration
  def self.up
    change_table :resources do |t|
      t.attachment :asset
    end
  end

  def self.down
    remove_attachment :resources, :asset
  end
end
