Sequel.migration do
  change do
    create_table :players do
      primary_key :id
      String :name, null: false
      foreign_key :match_id, :matches, null: false, on_delete: :cascade
      index :match_id
    end
  end
end
