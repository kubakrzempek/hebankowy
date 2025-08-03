import {inject, bindable} from "aurelia-framework";
import {CommentService} from "./comment.service";
import moment from "moment";

@inject(CommentService)
export class CommentsIndex {
  @bindable postId = undefined;
  @bindable parentId = undefined;
  @bindable comments = [];
  @bindable replying = false;
  newComment = {};

  constructor(commentService) {
    this.commentService = commentService;
  }

  formatDate(date) {
    return moment(date).format("(D MMMM 'YY)");
  }

  showReplyForm(commentId) {
    if (this.parentId) {
      this.replying = true;
    } else {
      var commentIds = this.comments.map(function(comment){ return comment.id });
      var index = commentIds.indexOf(commentId);
      this.comments[index].replying = true;
    }
  }

  cancelReplying() {
    this.replying = false;
  }

  create() {
    var params = {
      content: this.newComment.content,
      author_email: this.newComment.author_email,
      author_name: this.newComment.author_name,
      post_id: this.postId,
      parent_id: this.parentId,
    }

    this.commentService.create(params)
      .then(response => {
        if(response.ok) {
          this.replying = false;
          this.newComment = {};
          return response.json();
        } else {
          var error = new Error(response.statusText);
          error.response = response
          throw error;
        }
      })
      .then(comment => {
        if (this.parentId) {
          this.comments.push(comment)
        } else {
          this.comments.unshift(comment)
        }
      })
      .catch(err => {
        console.log("Something went wrong");
      });
  }
}
