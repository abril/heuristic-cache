# encoding: utf-8
require File.expand_path("heuristic_cache", File.dirname(__FILE__)) unless defined?(::HeuristicCache)

module HeuristicCache

  module Helpers

    def cacheable?(object)
      ::HeuristicCache.cacheable?(object)
    end

    def ttl_for(object, action)
      ::HeuristicCache::TTL.for(object, action)
    end

  end

end