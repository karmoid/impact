class AddStackedToDeployment < ActiveRecord::Migration
  def change
    add_column :deployments, :stacked, :boolean
  end
end
