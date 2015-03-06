Sequel.migration do

  up do
    extension :pg_enum

    alter_table(:matches) do
      drop_column :state
    end

    drop_enum(:match_state)
    create_enum(:match_state, %w(match_making in_progress finished))

    alter_table(:matches) do
      add_column :state, :match_state
    end

    self[:matches].update(state: "finished")

    alter_table(:matches) do
      set_column_not_null :state
    end
  end
end
