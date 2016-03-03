require 'test_helper'

class PledgeTest < Minitest::Test
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
    @g.save

    @g2 = Gift.new
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
    # Your setup goes here.
  end

  # Your tests are defined here.
  def test_collect_pledges
    assert_includes(Pledge.collect_pledges(@g.id), [@u.name, @u.email,@p.amount])
    assert_includes(Pledge.collect_pledges(@g.id), [@u2.name, @u2.email, @p2.amount])
    refute_includes(Pledge.collect_pledges(@g2.id),[@u2.name, @u2.email, @p2.amount])
  end

end