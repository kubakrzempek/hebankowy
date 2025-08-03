Sequel.migration do
  change do
    create_table(:photos) do
      primary_key :id
      String :image_uid
      String :title
      String :image_name
      Integer :image_width
      Integer :image_height
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
