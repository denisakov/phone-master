class CreateSiteUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :site_users do |t|

      t.timestamps
    end
  end
end
