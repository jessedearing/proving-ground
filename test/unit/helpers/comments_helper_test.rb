require 'test_helper'

class CommentsHelperTest < ActionView::TestCase
  test "gravatar urls should be correct" do
    email = "jesse.dearing@gmail.com"
    expected = "http://gravatar.com/avatar/ac32e9f15e9bc8f79a1ca4806b8cd760?s=32"

    assert_equal expected, gravatar_url(email)
  end

  test "gravatar urls should disregard case" do
    email = "JESSE.DeaRing@GMAil.COm"
    expected = "http://gravatar.com/avatar/ac32e9f15e9bc8f79a1ca4806b8cd760?s=32"

    assert_equal expected, gravatar_url(email)
  end

end
