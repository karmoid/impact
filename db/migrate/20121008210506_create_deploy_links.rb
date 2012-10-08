class CreateDeployLinks < ActiveRecord::Migration
  def change
    create_table :deploy_links do |t|
      t.integer :deployment_id
      t.integer :host_id

      t.timestamps
    end
  end
end
