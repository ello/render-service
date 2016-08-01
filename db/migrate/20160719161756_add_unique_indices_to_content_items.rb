class AddUniqueIndicesToContentItems < ActiveRecord::Migration[5.0]
  def change
    remove_index :rendered_content_items, [ :pipeline, :checksum ]
    add_index :rendered_content_items, [ :pipeline, :checksum ], unique: true
    add_index :source_content_items, [ :checksum ], unique: true
  end
end
