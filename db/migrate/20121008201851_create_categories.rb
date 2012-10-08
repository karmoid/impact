class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :note
      t.string :hr

      t.timestamps
    end
  end
end
