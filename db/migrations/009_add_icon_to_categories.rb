Sequel.migration do
  change do
    alter_table(:categories) do
      add_foreign_key :icon_id, :photos
    end
  end
end
