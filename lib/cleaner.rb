require 'json'

class Cleaner
  attr_accessor :hash
  def initialize(json)
    @hash = json
  end
end
