require File.expand_path "../../test_helper", __FILE__

class CategoryTest < Minitest::Test
  def teardown
    Category.all.each(&:destroy)
  end

  def test_invalid_category
    category = Category.new
    refute category.valid?
    assert_includes category.errors[:name], "is not present"
  end

  def test_valid_category
    category = Category.new name: "name"
    assert category.valid?, category.errors
  end

  def test_associations
    category = Category.new
    assert category.respond_to?(:photo)
    assert category.respond_to?(:posts)
  end
end
