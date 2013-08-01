# encoding: utf-8

require "spec_helper"
require 'timecop'

describe ::HeuristicCache::TTL do

  context "for method" do

    before(:each) do
      Timecop.travel(Time.local(2013, 1, 1, 15, 0, 0))
      Timecop.freeze(Time.local(2013, 1, 1, 15, 0, 0))

      ::HeuristicCache::Coefficient.stubs(:for).returns(0.1)
      ::HeuristicCache::TTL.stubs(:minimum).returns(60)
      ::HeuristicCache::TTL.stubs(:maximum).returns(86400)
    end

    after(:all) do
      Timecop.return
      
      ::HeuristicCache::Coefficient.unstub(:for)
      ::HeuristicCache::TTL.unstub(:minimum)
      ::HeuristicCache::TTL.unstub(:maximum)
    end
    
    it "should return the default_ttl for nil instances" do
      ::HeuristicCache::TTL.for(nil, :show).should == ::HeuristicCache::TTL.default
    end

    it "should return the default_ttl for objects that doesn't respond to updated_at" do
      ::HeuristicCache::TTL.for("", :show).should == ::HeuristicCache::TTL.default
    end

    it "should return the default_ttl for objects with null updated_at" do
      materia = HeuristicCacheObj.new(:updated_at => nil)
      ::HeuristicCache::TTL.for(materia, :show).should == ::HeuristicCache::TTL.default
    end

    it "should return a calculated ttl for objects with updated_at" do
      materia = HeuristicCacheObj.new(:updated_at => Time.parse("2013-01-01 10:00:00"))
      ::HeuristicCache::TTL.for(materia, :show).should == 1800 # 30 minutos
    end

    it "should return ::HeuristicCache::TTL.maximum of ttl for objects with old updated_at" do
      materia = HeuristicCacheObj.new(:updated_at => Time.parse("2000-01-01 10:00:00"))
      ::HeuristicCache::TTL.for(materia, :show).should == ::HeuristicCache::TTL.maximum
    end

    it "should return ::HeuristicCache::TTL.minimum of ttl for objects with very new updated_at" do
      materia = HeuristicCacheObj .new(:updated_at => Time.parse("2013-01-01 15:01:00"))
      ::HeuristicCache::TTL.for(materia, :show).should == ::HeuristicCache::TTL.minimum
    end

  end

end