class UsersFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :users_friends do |t|
      t.integer :user_id, foreign_key: true
      t.integer :friend_id, association_foreign_key: true
    end
  end
end
