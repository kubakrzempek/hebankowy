Sequel.migration do
  change do
    create_table(:categories) do
      primary_key :id
      foreign_key :photo_id, :photos
      String :name
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
