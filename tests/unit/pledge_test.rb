require 'test_helper'
#tests for methods on the Pledge models--
#setup creates users, gifts and pledges in the test database
#test_collect_pledges tests the collect_pledges method
class PledgeTest < Minitest::Test
    #sets up a test database
    def setup
        super
        @jillian = User.new
        @jillian.name = "Jillian"
        @jillian.email = "jillian@jillian.com"
        @jillian.save
    
        @shannon = User.new
        @shannon.name = "Shannon"
        @shannon.email = "shannon@jillian.com"
        @shannon.save
    
        @gift_banana= Gift.new
        @gift_banana.save
    
        @gift_potato = Gift.new
        @gift_potato.save
    
        @jillianpledge = Pledge.new
        @jillianpledge.gift_id = @gift_banana.id
        @jillianpledge.user_id = @jillian.id
        @jillianpledge.amount = 5.00
        @jillianpledge.save
    
        @shannonpledge = Pledge.new
        @shannonpledge.gift_id = @gift_banana.id
        @shannonpledge.user_id = @shannon.id
        @shannonpledge.amount = 10.00
        @shannonpledge.save
    end
    #tests method to find pledges for given gifts
    def test_collect_pledges
        assert_includes(Pledge.collect_pledges(@gift_banana.id),
        ["Jillian", "jillian@jillian.com", 5.00])
        assert_includes(Pledge.collect_pledges(@gift_banana.id),
        ["Shannon", "shannon@jillian.com", 10.00])
        refute_includes(Pledge.collect_pledges(@gift_potato.id),
        ["Shannon", "shannon@jillian.com", 5.00])
    end
end