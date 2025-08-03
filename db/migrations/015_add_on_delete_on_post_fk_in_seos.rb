Sequel.migration do
  change do
    alter_table(:seos) do
      drop_foreign_key [:post_id], name: :seos_post_id_fkey
      add_foreign_key [:post_id], :posts, on_delete: :cascade, name: :seos_post_id_fkey
    end
  end
end
