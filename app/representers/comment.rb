module Hebankowy
  module Representers
    Comment = Struct.new(:comment) do
      def basic
        {
          id: comment.id,
          author_name: comment.author_name,
          content: comment.content,
          replies: comment.replies_dataset.order(:created_at).map { |reply| Representers::Comment.new(reply).basic },
          created_at: comment.created_at,
        }
      end
    end
  end
end
