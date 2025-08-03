Sequel.migration do
  change do
    alter_table :posts do
      add_column :slug, String
    end
  end
end
