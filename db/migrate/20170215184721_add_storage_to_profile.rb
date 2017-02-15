class AddStorageToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :frequency, :string
    add_column :profiles, :files, :integer
    add_column :profiles, :storage, :string
  end
end
