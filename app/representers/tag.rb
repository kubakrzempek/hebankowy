module Hebankowy
  module Representers
    Tag = Struct.new(:tag) do
      def basic
        {
          id: tag.id,
          name: tag.name,
          created_at: tag.created_at,
          updated_at: tag.updated_at,
        }
      end
    end
  end
end
