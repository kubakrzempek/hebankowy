Sequel.migration do
  change do
    alter_table(:posts) do
      add_foreign_key :cover_photo_id, :photos
      add_foreign_key :featured_photo_id, :photos
    end
  end
end
