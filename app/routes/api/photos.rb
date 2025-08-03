module Hebankowy
  module Routes
    module Api
      class Photos < Base
        get_photos = lambda do
          photos = Photo.order(:updated_at).reverse.all
          json(
            photos.map do |photo|
              Representers::Photo.new(photo).basic
            end
          )
        end

        create_photo = lambda do
          filename = params["image"][:filename].gsub(" ", "_")
          file_path = "#{settings.root}/tmp/#{filename}"
          FileUtils.cp(params["image"][:tempfile], file_path)
          file = File.open(file_path)
          photo = Photo.new title: params["title"], image: file
          return_value = if photo.valid?
            photo.save
            status 201
            json Representers::Photo.new(photo).basic
          else
            status 422
            json photo.errors
          end
          file.close
          File.delete(file_path)
          return_value
        end

        get_photo = lambda do
          photo = Photo.with_pk!(params[:id])
          json Representers::Photo.new(photo).basic
        end

        update_photo = lambda do
          photo = Photo.with_pk!(params[:id])
          photo.strict_param_setting = false
          photo.update(params)
          json Representers::Photo.new(photo).basic
        end

        delete_photo = lambda do
          token = request.env.fetch("HTTP_AUTHORIZATION","").split.last
          if ::Hebankowy::Services::AuthToken.valid? token
            photo = Photo.with_pk!(params[:id])
            photo.destroy
            json Representers::Photo.new(photo).basic
          else
            status 404
            json({ errors: ["not found"] })
          end
        end

        process_photo = lambda do
          photo = Photo.with_pk!(params[:id])
          json({ url: photo.process(params).url })
        end

        namespace "/api/photos" do
          get "", &get_photos
          post "", &create_photo
          get "/:id", &get_photo
          put "/:id", &update_photo
          delete "/:id", &delete_photo
          get "/:id/process", &process_photo
        end
      end
    end
  end
end
