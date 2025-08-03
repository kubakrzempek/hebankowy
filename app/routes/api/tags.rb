module Hebankowy
  module Routes
    module Api
      class Tags < Base
        get_tags = lambda do
          json Tag.all.map { |tag| Representers::Tag.new(tag).basic }
        end

        create_tag = lambda do
          tag = Tag.new params
          if tag.valid?
            tag.save
            status 201
            json Representers::Tag.new(tag).basic
          else
            status 422
            json tag.errors
          end
        end

        get_tag = lambda do
          tag = Tag.with_pk!(params[:id])
          json Representers::Tag.new(tag).basic
        end

        update_tag = lambda do
          tag = Tag.with_pk!(params[:id])
          tag.strict_param_setting = false
          tag.update(params)
          json Representers::Tag.new(tag).basic
        end

        delete_tag = lambda do
          tag = Tag.with_pk!(params[:id])
          tag.destroy
          json Representers::Tag.new(tag).basic
        end

        namespace "/api/tags" do
          get "", &get_tags
          post "", &create_tag
          get ":id", &get_tag
          put ":id", &update_tag
          delete ":id", &delete_tag
        end
      end
    end
  end
end
