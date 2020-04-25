class CreateResourceRecords < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'ltree'

    create_table :resource_records do |t|
      t.ltree :name
      t.integer :type
      t.integer :ttl
      t.string :record

      t.index :name, using: :gist
    end
  end
end
