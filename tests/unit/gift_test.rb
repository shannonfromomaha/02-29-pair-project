require 'test_helper'
# tests for methods in the Gift model
# setup creates users, gifts and pledges in the test database
# test_pledge_math tests the pledge_math method
# test_funded_trigger tests the funded_trigger method
class GiftTest < Minitest::Test
  # sets up a gift database
  def setup
    super
    @user_a = User.new
    @user_a.name = "Jillian"
    @user_a.email = "jillian@jillian.com"
    @user_a.save

    @user_b = User.new
    @user_b.name = "Shannon"
    @user_b.email = "shannon@jillian.com"
    @user_b.save

    @gift_a = Gift.new
    @gift_a.cost = 20.00
    @gift_a.funded = false
    @gift_a.save

    @gift_b = Gift.new
    @gift_b.cost = 100.00
    @gift_b.funded = false
    @gift_b.save

    @pledge_a = Pledge.new
    @pledge_a.gift_id = @gift_a.id
    @pledge_a.user_id = @user_a.id
    @pledge_a.amount = 5.00
    @pledge_a.save

    @pledge_b = Pledge.new
    @pledge_b.gift_id = @gift_a.id
    @pledge_b.user_id = @user_b.id
    @pledge_b.amount = 10.00
    @pledge_b.save

    @pledge_c = Pledge.new
    @pledge_c.gift_id = @gift_b.id
    @pledge_c.user_id = @user_b.id
    @pledge_c.amount = 10.00
    @pledge_c.save
  end
# tests method that calculates all pledges on a gift
#
# pledge math method returns Array of total pledges and remaining gift cost
  def test_pledge_math
    assert_equal([15, 5], @gift_a.pledge_math)
    assert_equal([10, 90], @gift_b.pledge_math)
    refute_equal([10, 5], @gift_a.pledge_math)
    refute_equal([90, 10], @gift_b.pledge_math)
  end
# tests method that calculates if all pledges = cost of gift
#
# funded_trigger method returns Boolean of funded status
  def test_funded_trigger
    @pledge_d = Pledge.new
    @pledge_d.gift_id = @gift_a.id
    @pledge_d.amount = 5.00
    @pledge_d.save
    assert_equal(true, @gift_a.funded_trigger)
    refute_equal(true, @gift_b.funded_trigger)
  end
end