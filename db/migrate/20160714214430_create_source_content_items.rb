class CreateSourceContentItems < ActiveRecord::Migration[5.0]
  def change
    create_table :source_content_items do |t|
      t.text :content
      t.string :checksum
      t.timestamps
    end
  end
end
