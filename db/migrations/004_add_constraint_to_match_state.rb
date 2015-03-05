Sequel.migration do
  up do
    self[:matches].update(state: "match-making")
    alter_table(:matches) do
      set_column_not_null :state
    end
  end

  down do
    alter_table(:matches) do
      set_column_allow_null :state
    end
  end
end
