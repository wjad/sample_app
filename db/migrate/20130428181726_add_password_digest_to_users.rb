class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	#Lesson 6
  	#add_column :tablename, :addedcloumn, :type
    add_column :users, :password_digest, :string
  end
end
