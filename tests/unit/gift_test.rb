require 'test_helper'

class GiftTest < Minitest::Test
  def setup
    super
    @user = User.new
    @user.name = "Jillian"
    @user.email = "jillian@jillian.com"
    @user.save

    @user2 = User.new
    @user2.name = "Shannon"
    @user2.email = "shannon@jillian.com"
    @user2.save

    @gift = Gift.new
    @gift.cost = 20.00
    @gift.funded = false
    @gift.save

    @gift2 = Gift.new
    @gift2.cost = 100.00
    @gift2.funded = false
    @gift2.save

    @pledge = Pledge.new
    @pledge.gift_id = @gift.id
    @pledge.user_id = @user.id
    @pledge.amount = 5.00
    @pledge.save

    @pledge2 = Pledge.new
    @pledge2.gift_id = @gift.id
    @pledge2.user_id = @user2.id
    @pledge2.amount = 10.00
    @pledge2.save

    @pledge3 = Pledge.new
    @pledge3.gift_id = @gift2.id
    @pledge3.user_id = @user2.id
    @pledge3.amount = 10.00
    @pledge3.save
  end

  def test_pledge_math
    assert_equal([15, 5], @gift.pledge_math)
    assert_equal([10, 90], @gift2.pledge_math)
    refute_equal([10, 5], @gift.pledge_math)
    refute_equal([90, 10], @gift2.pledge_math)
  end

  def test_funded_trigger
    @pledge4 = Pledge.new
    @pledge4.gift_id = @gift.id
    @pledge4.amount = 5.00
    @pledge4.save
    assert_equal(true, @gift.funded_trigger)
    refute_equal(true, @gift2.funded_trigger)
  end
end