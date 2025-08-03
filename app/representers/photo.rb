module Hebankowy
  module Representers
    Photo = Struct.new(:photo, :width) do
      def basic
        {
          id: photo.id,
          url: width ? photo.image.thumb("#{width}x").encode("jpg", "-quality 55").url : photo.image.url,
          title: photo.title,
          created_at: photo.created_at,
          updated_at: photo.updated_at,
        }
      end
    end
  end
end
