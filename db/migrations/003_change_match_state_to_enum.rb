Sequel.migration do
  up do
    alter_table :matches do
      drop_column :state
      add_column :state, :match_state
    end
  end

  down do
    alter_table :matches do
      drop_column :state
      add_column :state, String
    end
  end
end
