require 'test_helper'

class GiftTest < Minitest::Test
  def setup
    super
    @u = User.new
    @u.name = "Jillian"
    @u.email = "jillian@jillian.com"
    @u.save

    @u2 = User.new
    @u2.name = "Shannon"
    @u2.email = "shannon@jillian.com"
    @u2.save

    @g = Gift.new
    @g.cost = 20.00
    @g.funded = false
    @g.save

    @g2 = Gift.new
    @g2.cost = 100.00
    @g2.funded = false
    @g2.save

    @p = Pledge.new
    @p.gift_id = @g.id
    @p.user_id = @u.id
    @p.amount = 5.00
    @p.save

    @p2 = Pledge.new
    @p2.gift_id = @g.id
    @p2.user_id = @u2.id
    @p2.amount = 10.00
    @p2.save

    @p3 = Pledge.new
    @p3.gift_id = @g2.id
    @p3.user_id = @u2.id
    @p3.amount = 10.00
    @p3.save
  end

  def test_pledge_math
    assert_equal([15, 5], @g.pledge_math)
    assert_equal([10, 90], @g2.pledge_math)
    refute_equal([10, 5], @g.pledge_math)
    refute_equal([90, 10], @g2.pledge_math)
  end

  def test_funded_trigger
    @p4 = Pledge.new
    @p4.gift_id = @g.id
    @p4.amount = 5.00
    @p4.save
    assert_equal(true, @g.funded_trigger)
    refute_equal(true, @g2.funded_trigger)
  end
end