require "spec_helper"

describe "AlxHeuristicCache::Helpers" do

  context "When call any helper" do

    it "should call class HeuristicCache.cacheable?" do 
      ::HeuristicCache.expects(:cacheable?).returns(true)
      TestAlxHeuristicCache.new.cacheable?("teste")
    end

    it "should call class HeuristicCache::TTL.for" do 
      ::HeuristicCache::TTL.expects(:for).returns(1)
      TestAlxHeuristicCache.new.ttl_for("teste", "new")
    end

  end

end

class TestAlxHeuristicCache
  include AlxHeuristicCache::Helpers
end