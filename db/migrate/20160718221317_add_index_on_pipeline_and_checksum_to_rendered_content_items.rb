class AddIndexOnPipelineAndChecksumToRenderedContentItems < ActiveRecord::Migration[5.0]

  disable_ddl_transaction!

  def change
    add_index :rendered_content_items, [ :pipeline, :checksum ], algorithm: :concurrently
  end
end
