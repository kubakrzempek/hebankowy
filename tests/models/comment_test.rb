require File.expand_path "../../test_helper", __FILE__

class CommentTest < Minitest::Test
  def teardown
    Comment.all.each(&:destroy)
  end

  def test_invalid_comment
    comment = Comment.new
    refute comment.valid?
    assert_includes comment.errors[:content], "is not present"
    assert_includes comment.errors[:ip_address], "is not present"
    assert_includes comment.errors[:author_email], "is not present"
    assert_includes comment.errors[:author_name], "is not present"
  end

  def test_associations
    comment = Comment.new
    assert comment.respond_to? :parent, "Parent comment not associated"
    assert comment.respond_to? :post, "Post not associated"
    assert comment.respond_to? :replies, "Replies not associated"
  end
end
