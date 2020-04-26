class CreateResourceRecords < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'ltree'

    create_table :resource_records do |t|
      t.ltree :host_name
      t.integer :record_type
      t.integer :ttl
      t.string :record_value

      t.index :host_name, using: :gist
    end
  end
end
