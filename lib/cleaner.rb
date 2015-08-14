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

  def purge
    p = Proc.new do |k,v|
      if is_collection?(v)
        v.each do |h|
          h.delete_if(&p)
        end
      end
      keys.include?(k)
    end
    @hash.each do |k, v|
      if is_collection?(v)
        v.each do |obj|
          obj.delete_if(&p)
        end
      end
    end
    @hash
  end

  private
  def keys
    @hash.keys
  end

  def is_collection?(value)
    return false unless value.is_a?(Array)
    value.all?{ |x| x.is_a?(Hash) }
  end
end
