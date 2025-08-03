Sequel.migration do
  change do
    alter_table :posts do
      add_column :distance, Integer, default: 0
    end
  end
end
