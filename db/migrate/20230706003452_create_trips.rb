class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :status
      t.string :location
      t.datetime :eta
      t.datetime :etc
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.references :owner, index: true, foreign_key: { to_table: :users }
      t.references :assignee, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
