# encoding: utf-8
module AlxHeuristicCache

  module Helpers

    def cacheable?(object)
      ::HeuristicCache.cacheable?(object)
    end

    def ttl_for(object, action)
      ::HeuristicCache::TTL.for(object, action)
    end

  end

end