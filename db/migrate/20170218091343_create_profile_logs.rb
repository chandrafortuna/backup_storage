class CreateProfileLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_logs do |t|
      t.string :title
      t.string :path
      t.belongs_to :profile, index: true

      t.timestamps
    end
  end
end
