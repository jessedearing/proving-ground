require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "Node returns #{POSTS_ON_FRONT_PAGE} nodes with top_posts scope" do
    assert Node.top_posts.all.size == POSTS_ON_FRONT_PAGE
    assert Node.all.size > POSTS_ON_FRONT_PAGE
  end

  test "Node publish returns only published nodes" do
    published = Node.published.all

    published.each do |p|
      assert_not_nil p.publish_date
      assert p.publish_date > Time.now
    end
  end
end
