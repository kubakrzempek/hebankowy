Sequel.migration do
  change do
    create_join_table(post_id: :posts, category_id: :categories)
  end
end
