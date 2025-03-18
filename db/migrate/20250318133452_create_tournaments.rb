class CreateTournaments < ActiveRecord::Migration[8.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :game
      t.references :organizer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
