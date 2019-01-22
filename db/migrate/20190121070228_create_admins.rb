class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
        t.string"first_name",:limit=> 50, :null=> false
        t.string"last_name",:limit =>50, :null=> false
        t.string"email",:default => "", :null=> false
        t.boolean"sent",:default => false
              t.timestamps
          end
      end
end
