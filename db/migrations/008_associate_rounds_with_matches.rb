Sequel.migration do
  change do
    alter_table(:rounds) do
      add_foreign_key :match_id, :matches, null: false, on_delete: :cascade
      add_index :match_id
    end
  end
end
