require "pry"

module Hebankowy
  module Routes
    module Api
      class Posts < Base
        def nbsp
          " "
        end

        def set_nbsp!(input)
          input.gsub!(/\s\S\s/) do |match|
            match[-1] = nbsp
            match
          end
        end

        get_posts = lambda do
          posts = Post.published.reverse_order(:published_at).offset(1).all
          json(
            posts.map do |post|
              Representers::Post.new(post).minimal
            end
          )
        end

        create_post = lambda do
          set_nbsp!(params[:content])
          params[:slug] = params[:title].slugify if params[:slug].length.zero?
          params[:slug] = params[:slug].slugify
          post = Post.new
          post.set_fields(params, %i{title slug content teaser})
          if post.valid?
            post.save
            status 201
            json Representers::Post.new(post).basic
          else
            status 422
            json post.errors
          end
        end

        get_post = lambda do
          post = Post.where(slug: params[:slug]).first
          post = Post.with_pk!(params[:slug]) unless post
          json Representers::Post.new(post).basic
        end

        update_post = lambda do
          set_nbsp!(params[:post][:content])
          params[:post][:slug] = params[:post][:title].slugify if params[:post][:slug].length.zero?
          params[:post][:slug] = params[:post][:slug].slugify
          post = Post.with_pk!(params[:id])
          post.strict_param_setting = false
          post.update(params[:post].select { |key, _| post_attributes.include?(key) })
          post.seo.update(params[:post][:seo])
          json Representers::Post.new(post).basic
        end

        delete_post = lambda do
          post = Post.with_pk!(params[:id])
          post.delete
          json Representers::Post.new(post).basic
        end

        like_post = lambda do
          post = Post.with_pk!(params[:id])
          post.like!
          json Representers::Post.new(post).minimal
        end

        admin_list = lambda do
          posts = Post.reverse_order(:created_at).all
          json(
            posts.map do |post|
              Representers::Post.new(post).minimal
            end
          )
        end

        get_newest = lambda do
          post = Post.published.reverse_order(:published_at).limit(1).first
          json(
            Representers::Post.new(post).minimal
          )
        end

        namespace "/api/posts" do
          get "", &get_posts
          get "/all", &admin_list
          get "/newest", &get_newest
          post "", &create_post
          get "/:slug", &get_post
          put "/:id", &update_post
          # delete "/:id/?", &delete_post
          post "/:id/like", &like_post
        end

        private

        def post_attributes
          %w(
            title content slug teaser hints location distance route
            banner_photo_url cover_photo_url featured_photo_url
            mobile_featured_photo_url mobile_cover_photo_url
          )
        end
      end
    end
  end
end
