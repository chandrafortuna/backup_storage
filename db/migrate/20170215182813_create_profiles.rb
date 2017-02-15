class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :paths
      t.string :excludes
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
