require File.expand_path "../../test_helper", __FILE__

class TagTest < Minitest::Test
  def teardown
    Tag.all.each(&:destroy)
  end

  def test_invalid_tag
    tag = Tag.new
    refute tag.valid?
    assert_includes tag.errors[:name], "is not present"
  end

  def test_valid_tag
    tag = Tag.new name: "name"
    assert tag.valid?, tag.errors
  end

  def test_associations
    tag = Tag.new
    assert tag.respond_to?(:posts)
  end
end
