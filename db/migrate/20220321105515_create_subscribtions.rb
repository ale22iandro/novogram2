class CreateSubscribtions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribtions do |t|
      t.integer :followed_id
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
