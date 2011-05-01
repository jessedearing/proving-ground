require 'test_helper'

class NodesHelperTest < ActionView::TestCase
  attr_accessor :params

  test "paging should return if the posts are greater than the POSTS_ON_FRONT_PAGE constant" do
    self.params = {}
    expected = '<div class="grid_16" id="pagination"><a href="/?page=2">Next &gt;&gt;</a></div>'
    actual = paging(10)

    assert_equal expected, actual
  end

  test "paging should not return if posts are less than the POSTS_ON_FRONT_PAGE constant" do
    self.params = {}
    expected = '<div class="grid_16" id="pagination"></div>'
    actual = paging(2)

    assert_equal expected, actual
  end

  test "paging should return correct page if page is greater than 1" do
    self.params = {:page => "3"}
    expected = '<div class="grid_16" id="pagination"><a href="/?page=4">Next &gt;&gt;</a></div>'
    actual = paging(19)

    assert_equal expected, actual
  end
end
