Sequel.migration do
  change do
    alter_table :posts do
      add_column :published_at, DateTime
    end
  end
end
