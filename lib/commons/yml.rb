# encoding: UTF-8

module Commons

  require "yaml"
  
  class Yml < Hash
    
    attr_accessor :from
    
    def initialize(from)
      self.from = from
    end
    
    def self.read(file)

      raise ArgumentError, 'Param file é required' if file == nil

      yaml_file = file.end_with?(".yml") ? file : "#{file}.yml"
      begin
        yaml_configs = YAML::load_file(yaml_file)
        return self.prepare_configs(yaml_configs, yaml_file, true)
      rescue Exception => e
        message = "Error when reading yml file: #{e.message}"        
        STDOUT.puts(message)
        raise e
      end
    end
    
    def [](key)
      prepare_value(super(key), key)
    end
    
    def fetch(*args)
      begin
        return prepare_value(super(*args), args.first)
      rescue IndexError => e
        message = "Missing attribute '#{args.first}' in #{self.from}"
        STDOUT.puts(message)
        raise RuntimeError.new(message)
      end
    end

    def self.prepare_configs(configs, file, symbolize_keys = false)
      if configs.is_a?(Hash) 
        configs.symbolize_keys! if symbolize_keys && configs.respond_to?(:symbolize_keys!)
        configs = Yml.new(file).merge(configs)
      end
      configs
    end
    
    private
    def prepare_value(value, from_key)
      value.is_a?(Hash) ? Yml.new("'#{from_key}:#{self.from}'").merge(value) : value
    end
    
  end

end
