Sequel.migration do
  change do
    alter_table(:matches) do
      add_column :name, String
    end
  end
end
