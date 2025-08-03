module Hebankowy
  module Routes
    module Api
      class Comments < Base
        create_comment = lambda do
          comment = Comment.new(ip_address: request.ip, author_email: "")
          comment.set_fields(params, %i{author_name content post_id parent_id})
          if comment.valid?
            comment.save
            status 201
            json Representers::Comment.new(comment).basic
          else
            status 422
            json comment.errors
          end
        end

        delete_comment = lambda do
          comment = Comment.with_pk!(params[:id])
          comment.destroy
          json Representers::Comment.new(comment).basic
        end

        namespace "/api/comments" do
          post "", &create_comment
          # delete ":id/?", &delete_comment
        end
      end
    end
  end
end
