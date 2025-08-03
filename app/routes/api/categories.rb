module Hebankowy
  module Routes
    module Api
      class Categories < Base
        get_categories = lambda do
          json Category.all.map { |category| Representers::Category.new(category).basic }
        end

        create_category = lambda do
          category = Category.new params
          if category.valid?
            category.save
            status 201
            json Representers::Category.new(category).basic
          else
            status 422
            json category.errors
          end
        end

        get_category = lambda do
          category = Category.find(name: params[:id])
          json category ? Representers::Category.new(category).with_posts : not_found
        end

        update_category = lambda do
          category = Category.with_pk!(params[:id])
          category.strict_param_setting = false
          category.update(params)
          json Representers::Category.new(category).basic
        end

        delete_category = lambda do
          category = Category.with_pk!(params[:id])
          category.destroy
          json Representers::Category.new(category).basic
        end

        namespace "/api/categories" do
          get "", &get_categories
          post "", &create_category
          get ":id", &get_category
          put ":id", &update_category
          # delete ":id/?", &delete_category
        end
      end
    end
  end
end
