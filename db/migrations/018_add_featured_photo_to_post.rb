Sequel.migration do
  change do
    alter_table :posts do
      add_column :banner_photo_url, String
      add_column :cover_photo_url, String
      add_column :featured_photo_url, String
      add_column :mobile_cover_photo_url, String
      add_column :mobile_featured_photo_url, String
    end
  end
end
