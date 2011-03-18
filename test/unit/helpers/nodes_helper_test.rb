require 'test_helper'

class NodesHelperTest < ActionView::TestCase
  test "titles should be SEO" do
    input = "Titles #101: what's up with that/them?"
    expected = "Titles--101--what-s-up-with-that-them-"
    assert_equal expected, seoize(input)
  end
end
