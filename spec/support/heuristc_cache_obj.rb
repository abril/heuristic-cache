class HeuristicCacheObj
  attr_accessor :status, :updated_at
  def initialize(hash)
    @status = hash[:status]
    @updated_at = hash[:updated_at]
  end
end