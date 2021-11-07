class CreateWickets < ActiveRecord::Migration[6.1]
  def change
    create_table :wickets do |t|
      t.integer :bowler_id, null: false, index: true
      t.integer :batsman_id, null: false, index: true
      t.string :wicket_type, null: false
      t.integer :ball_id, null: false, index: true
      t.integer :fielder_id, index: true

      t.timestamps
    end
  end
end
