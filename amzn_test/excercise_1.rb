ANYTHING = "anything"

def checkWinner(codeList, shoppingCart)
  codeList.inject(shoppingCart) do |cart, current|
    cart = cart_matches(current, cart)
    unless cart
      return 0
    end
    cart
  end
  return 1
end

def cart_matches(code_list, cart)
  return false if cart.length < code_list.length
  (cart.length - code_list.length + 1).times do |start_index|
    if lists_match(code_list, cart[start_index..(start_index+code_list.length-1)])
      return cart[(start_index+code_list.length)..(cart.length-1)]
    end
  end
  return false
end

def lists_match(code_list, cart)
  code_list.length.times do |item_index|
    if code_list[item_index] != ANYTHING && code_list[item_index] != cart[item_index]
      return false
    end
  end
  return true
end

require 'test/unit'

class TestThis < Test::Unit::TestCase

  def test_list_match
    assert lists_match(%w{a b c}, %w{a b c})
    assert lists_match(%w{a}, %w{a})
    assert lists_match(%w{anything}, %w{a})
    assert lists_match(%w{anything anything anything}, %w{a b c})
    assert lists_match(%w{anything b anything}, %w{a b c})
    assert !lists_match(%w{anything b anything}, %w{a x c})
  end

  def test_cart_matches
    assert_equal %w{b c d}, cart_matches(%w{a}, %w{a b c d})
    assert_equal %w{c d}, cart_matches(%w{a b}, %w{a b c d})
    assert_equal %w{d}, cart_matches(%w{a b c}, %w{a b c d})
    assert_equal %w{}, cart_matches(%w{a b c d}, %w{a b c d})
    assert_equal %w{}, cart_matches(%w{b c d}, %w{a b c d})
    assert_equal %w{}, cart_matches(%w{c d}, %w{a b c d})
    assert_equal %w{}, cart_matches(%w{d}, %w{a b c d})
  end
end