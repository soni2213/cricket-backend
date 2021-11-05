class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.integer :team1_id, index: true, null: false
      t.integer :team2_id, index: true, null: false
      t.integer :winner_id, index: true
      t.integer :toss_winner_id

      t.timestamps
    end
  end
end
