Sequel.migration do
  change do
    create_table(:guesses) do
      primary_key :id
      column :code_pegs, "code_peg[]", null: false
      foreign_key :player_id, :players, null: false, on_delete: :restrict
      foreign_key :round_id, :rounds, null: false, on_delete: :cascade
      index :player_id
      index :round_id
    end
  end
end
