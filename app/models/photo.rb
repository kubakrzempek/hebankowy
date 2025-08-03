module Hebankowy
  module Models
    class Photo < Sequel::Model
      extend Dragonfly::Model

      one_to_many :categories
      one_to_many :covers, class: Post, key: :cover_id
      one_to_many :features, class: Post, key: :featured_photo_id

      dragonfly_accessor :image

      def process(params)
        crop_x = params[:offset_x].to_i
        crop_y = params[:offset_y].to_i
        crop_width = params[:width_x].to_i - crop_x
        crop_height = params[:width_y].to_i - crop_y
        crop_string = "-crop #{crop_width}x#{crop_height}+#{crop_x}+#{crop_y}"

        resize_width = params[:width].to_i
        resize_string = resize_width ? "-resize #{resize_width}x" : ""

        image.convert("#{crop_string}")
      end

      private

      def before_save
        save_dragonfly_attachments
        super
      end

      def after_destroy
        destroy_dragonfly_attachments
        super
      end

      def validate
        super
        validates_presence [:title, :image]
      end
    end
  end
end
