Sequel.migration do
  change do
    create_table(:matches) do
      primary_key :id
      String :state, :null=>false
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:players, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :text=>true, :null=>false
      foreign_key :match_id, :matches, :null=>false, :key=>[:id], :on_delete=>:cascade
      
      index [:match_id]
    end
  end
end
