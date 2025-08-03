Sequel.migration do
  change do
    alter_table :posts do
      add_column :teaser, String
      add_column :location, String
      add_column :hints, String
    end
  end
end
