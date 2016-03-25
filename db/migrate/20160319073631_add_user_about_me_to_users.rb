class AddUserAboutMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_about_me, :string
  end
end
