Sequel.migration do
  change do
    create_table(:tags) do
      primary_key :id
      String :name
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
