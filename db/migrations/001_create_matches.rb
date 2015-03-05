Sequel.migration do
  change do
    create_table :matches do
      primary_key :id
      String :state, null: false
    end
  end
end
