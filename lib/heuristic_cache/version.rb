# encoding: UTF-8
module AlxHeuristicCache

  module VERSION
    @@version = nil
    def self.version
      if @@version == nil
        txt = File.expand_path(File.join(*%w[.. .. .. CURRENT_VERSION]), __FILE__)
        if File.exists?(txt)
          @@version = File.read(txt).chomp.gsub("v","")
        else
          @@version = "0.0.1"
        end
      end
      @@version
    end

    def self.to_s
      self.version
    end

  end

end