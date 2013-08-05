require "spec_helper"

describe "HeuristicCache::Helpers" do
  context "When call any helper" do
    it "should call class HeuristicCache.cacheable?" do 
      ::HeuristicCache.expects(:cacheable?).returns(true)
      TestHeuristicCache.new.cacheable?("teste")
    end

    it "should call class HeuristicCache::TTL.for" do 
      ::HeuristicCache::TTL.expects(:for).returns(1)
      TestHeuristicCache.new.ttl_for("teste", "new")
    end
  end
end

class TestHeuristicCache
  include HeuristicCache::Helpers
end
