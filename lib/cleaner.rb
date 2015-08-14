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

  def clean
    keys = @hash.keys
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
  end

  private
  def organize
    #@keys = hash.keys
    #keys.each do |k|
    #  val = @hash[k]
    #  if val.respond_to?(:delete_if)
    #    case val
    #    when Array
    #    when Hash
    #    end
    #  end
  end

  def is_collection?(value)
    return false unless value.is_a?(Array)
    value.all?{ |x| x.is_a?(Hash) }
  end
end
