Sequel.migration do
  up do
    extension :pg_enum
    create_enum(:match_state, %w(match-making in-progress finished))
  end

  down do
    extension :pg_enum
    drop_enum(:match_state)
  end
end
