# encoding: utf-8

require "spec_helper"

describe ::HeuristicCache do
  context "cacheable? method" do

    it "should return false for a nil parameter" do
      ::HeuristicCache.cacheable?(nil).should == false
    end

    it "should return false for a object without status method" do
      ::HeuristicCache.cacheable?("").should == false
    end

    it "should return false for a object with rascunho status" do
      ::HeuristicCache.cacheable?(HeuristicCacheObj.new(:status => "rascunho")).should == false
    end

    it "should return false for a object with agendado status" do
      ::HeuristicCache.cacheable?(HeuristicCacheObj.new(:status => "agendado")).should == false
    end

    it "should return true for a object with disponivel status" do
      ::HeuristicCache.cacheable?(HeuristicCacheObj.new(:status => "disponivel")).should == true
    end

  end

end