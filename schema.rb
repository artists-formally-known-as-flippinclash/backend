Sequel.migration do
  change do
    create_table(:matches) do
      primary_key :id
      String :channel, :text=>true, :null=>false
      String :state, :text=>true, :null=>false
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
  end
end
