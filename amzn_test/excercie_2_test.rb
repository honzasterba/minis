require "./amzn_test/excercise_2_submited"
require 'test/unit'

class TestThis < Test::Unit::TestCase

  def test_build
    assert_equal Node.new(1), build_tree([1])
    assert_equal Node.new(1, Node.new(2, Node.new(3))),
                 build_tree([1, 2, 3])
    assert_equal Node.new(3, nil, Node.new(2, nil,Node.new(1))),
                 build_tree([3, 2, 1])
    assert_equal Node.new(10,
                          nil,
                          Node.new(5,
                                   Node.new(7),
                                   Node.new(3))
    ),
                 build_tree([10, 5, 3, 7])
  end

  def test_distance
    assert_equal 3, bstDistance([5,6,3,1,2,4], 6,2,4)
    assert_equal 2, bstDistance([5,6,3,1,2,4], 6,6,3)
    assert_equal 1, bstDistance([5,6,3,1,2,4], 6,5,3)
    assert_equal 4, bstDistance([5,6,3,1,2,4], 6,6,2)
    assert_equal 1, bstDistance([5,6,3,1,2,4], 6,1,2)
    assert_equal 2, bstDistance([5,6,3,1,2,4], 6,1,4)

    assert_equal 5, bstDistance([1,2,3,4,5,6], 6,1,6)
    assert_equal 5, bstDistance([1,2,3,4,5,6], 6,6,1)
  end

  def test_find_in_subtree
    tree = build_tree([5,6,3,1,2,4])
    assert_equal 0, find_in_subtree(tree, 5)
    assert_equal 1, find_in_subtree(tree, 3)
    assert_equal 3, find_in_subtree(tree, 2)
  end

end