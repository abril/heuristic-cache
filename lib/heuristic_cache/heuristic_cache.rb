# encoding: UTF-8

module HeuristicCache
  CACHEABLE_STATUSES  = Array.new

  def self.init(file, env = 'development')

    raise ArgumentError, 'Param env is required' if env == nil

    config = ::Commons::Yml.read(file)[env.to_s]['cache_config']

    STDOUT.puts 'WARNING: attr time_to_live is required' if config["time_to_live"] == nil
    TTL.init(config["time_to_live"])

    STDOUT.puts 'WARNING: attr coefficient is required' if config["coefficient"] == nil
    Coefficient.init(config["coefficient"])

    CACHEABLE_STATUSES.concat(config["cacheable_statuses"])

    nil

  end

  def self.cacheable?(object)
    CACHEABLE_STATUSES.empty? ? true : object.respond_to?(:status) && CACHEABLE_STATUSES.include?(object.status)
  end
  
  class TTL

    def self.init(yml)
      @ttls = yml
    end

    def self.maximum
      @ttls["maximum"]
    end

    def self.greater_than_maximum?(value)
      value > self.maximum
    end

    def self.minimum
      @ttls["minimum"]
    end

    def self.lower_than_minimum?(value)
      value < self.minimum
    end

    def self.default
      @ttls["default"]
    end
   
    def self.for(object, action)
      return TTL.default unless object.respond_to?(:updated_at) && !object.updated_at.nil?

      difference    = Time.now.to_i - object.updated_at.to_i
      coefficient   = Coefficient.for(object.class.to_s.downcase, action)
      heuristic_ttl = (difference * coefficient).to_i
      
      return TTL.minimum if TTL.lower_than_minimum?(heuristic_ttl)
      return TTL.maximum if TTL.greater_than_maximum?(heuristic_ttl)

      heuristic_ttl
    end

  end

  class Coefficient
    def self.init(yml)
      @coefficients = yml
    end
    def self.for(model, action)
      @coefficients[model][action.to_s]
    end
  end

end