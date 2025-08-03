Sequel.migration do
  change do
    create_table(:seos) do
      primary_key :id
      String :title
      String :description
      String :image
      foreign_key :post_id, :posts
    end
  end
end
