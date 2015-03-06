Sequel.migration do
  up do
    extension :pg_enum
    extension :pg_array

    create_enum(:code_peg, %w(alpha beta gamma delta epsilon zeta))

    create_table :rounds do
      primary_key :id
      column :solution, "code_peg[]", null: false
      Boolean :finished, null: false, default: false
    end
  end

  down do
    extension :pg_enum

    drop_table(:rounds)
    drop_enum(:code_peg)
  end
end
