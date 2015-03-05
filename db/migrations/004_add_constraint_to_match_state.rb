Sequel.migration do
  change do
    alter_table(:matches) do
      set_column_not_null :state
    end
  end
end
