Sequel.migration do
  change do
    alter_table :posts do
      add_column :likes, Integer, default: 0
    end
  end
end
