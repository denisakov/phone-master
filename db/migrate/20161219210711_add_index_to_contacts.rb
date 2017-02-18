class AddIndexToContacts < ActiveRecord::Migration[5.0]
  def change
    #add_column :contacts, :phone, :string
    add_index :contacts, :phone, unique: true
  end
end
