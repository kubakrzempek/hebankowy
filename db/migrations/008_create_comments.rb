Sequel.migration do
  change do
    create_table(:comments) do
      primary_key :id
      foreign_key :parent_id, :comments
      foreign_key :post_id, :posts
      String :content, null: false
      String :author_email, null: false
      String :author_name, null: false
      String :ip_address, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
