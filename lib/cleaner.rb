require 'json'

class Cleaner
  attr_accessor :hash
  def initialize(json)
    @hash = case json
            when Hash then json
            when String then JSON.parse(json)
            else
              raise "This isn't valide data!"
            end
  end
end
