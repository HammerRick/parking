class CreateParkingTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :parking_tickets do |t|
      t.datetime :in_at
      t.datetime :out_at
      t.boolean :paid, default: false
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
