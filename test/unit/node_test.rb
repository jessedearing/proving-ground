require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "Node returns 6 nodes with top5 scope" do
    assert Node.top5.all.size == 6
    assert Node.all.size > 6
  end

  test "Node publish returns only published nodes" do
    published = Node.published.all

    published.each do |p|
      assert_not_nil p.publish_date
      assert p.publish_date > Time.now
    end
  end
end
