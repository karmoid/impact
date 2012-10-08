class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.string :name
      t.text :note
      t.string :hr
      t.references :sub_category

      t.timestamps
    end
    add_index :deployments, :sub_category_id
  end
end
