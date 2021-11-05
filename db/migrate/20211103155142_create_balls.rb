class CreateBalls < ActiveRecord::Migration[6.1]
  def change
    create_table :balls do |t|
      t.integer :bowler_id, null: false
      t.integer :batsman_id, null: false
      t.integer :match_id, index: true, null: false
      t.integer :score, null: false, default: 0
      t.boolean :extra, null: false, default: false

      t.timestamps
    end
  end
end
