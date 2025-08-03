require File.expand_path "../../test_helper", __FILE__

class PhotoTest < Minitest::Test
  def teardown
    Photo.all.each(&:destroy)
  end

  def test_invalid_photo
    photo = Photo.new
    refute photo.valid?
    assert_includes photo.errors[:title], "is not present"
    assert_includes photo.errors[:image], "is not present"
  end

  def test_valid_photo
    photo = Photo.new title: "title", image: "image"
    assert photo.valid?, photo.errors
  end

  def test_associations
    photo = Photo.new
    assert photo.respond_to? :covers, "Features not associated"
    assert photo.respond_to? :features, "Covers not assovciated"
    assert photo.respond_to? :categories, "Categories not associated"
  end

  def test_save_dragonfly_attachments
    photo = Photo.new title: "title", image: "image"
    save_attachments_mock = MiniTest::Mock.new
    save_attachments_mock.expect :call, nil
    photo.stub(:save_dragonfly_attachments, save_attachments_mock) do
      photo.save
    end
    save_attachments_mock.verify
  end

  def test_destroy_dragonfly_attachments
    photo = Photo.create title: "title", image: "image"
    destroy_attachments_mock = MiniTest::Mock.new
    destroy_attachments_mock.expect :call, nil
    photo.stub(:destroy_dragonfly_attachments, destroy_attachments_mock) do
      photo.destroy
    end
    destroy_attachments_mock.verify
  end
end
