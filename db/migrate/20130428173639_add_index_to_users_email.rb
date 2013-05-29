class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	#add_index is part of ActiveRecord::Migration
  	# Argument: name of the table=>:email, name of the column=> :email and unique to be true.
  	#This is gonna help in avoiding full table scan.
  	add_index :users, :email, unique: true
  end
end
