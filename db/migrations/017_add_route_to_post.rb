Sequel.migration do
  change do
    alter_table :posts do
      add_column :route, String
    end
  end
end
