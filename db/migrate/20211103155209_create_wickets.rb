class CreateWickets < ActiveRecord::Migration[6.1]
  def change
    create_table :wickets do |t|
      t.integer :bowler_id, null: false
      t.integer :batsman_id, null: false
      t.string :wicket_type, null: false
      t.integer :ball_id, null: false
      t.integer :fielder_id

      t.timestamps
    end
  end
end
