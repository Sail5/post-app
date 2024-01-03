class AddUserNameToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :user_name, :string
  end
  def change
    add_reference :posts, :user, foreign_key: true
  end
end
