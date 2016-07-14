class CreateRenderedContentItems < ActiveRecord::Migration[5.0]
  def change
    create_table :rendered_content_items do |t|
      t.text :content
      t.string :checksum
      t.string :pipeline
      t.references :source_content_item, foreign_key: true
      t.string :version
      t.timestamps
    end
  end
end
