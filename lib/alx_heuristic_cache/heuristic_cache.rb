# encoding: UTF-8

module AlxHeuristicCache

  CACHEABLE_STATUSES = [ "disponivel" ] unless defined? ::CACHEABLE_STATUSES 

  def self.cacheable?(object)
    object.respond_to?(:status) && ::CACHEABLE_STATUSES.include?(object.status)
  end
  
  class TTL
    def self.init(yml)
      @ttls = yml
    end
    def self.maximum
      @ttls[:maximum]
    end
    def self.greater_than_maximum?(value)
      value > self.maximum
    end
    def self.minimum
      @ttls[:minimum]
    end
    def self.lower_than_minimum?(value)
      value < self.minimum
    end
    def self.default
      @ttls[:default]
    end
    def self.for(object, action)
      return ::HeuristicCache::TTL.default unless object.respond_to?(:updated_at) && !object.updated_at.nil?

      difference    = Time.now.to_i - object.updated_at.to_i
      coefficient   = ::HeuristicCache::Coefficient.for(object.class.to_s.underscore.to_sym, action.to_sym)
      heuristic_ttl = (difference * coefficient).to_i
      
      return ::HeuristicCache::TTL.minimum if ::HeuristicCache::TTL.lower_than_minimum?(heuristic_ttl)
      return ::HeuristicCache::TTL.maximum if ::HeuristicCache::TTL.greater_than_maximum?(heuristic_ttl)

      heuristic_ttl
    end
  end

  class Coefficient
    def self.init(yml)
      @coefficients = yml
    end
    def self.for(model, action)
      @coefficients[model][action]
    end
  end

end