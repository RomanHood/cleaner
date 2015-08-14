require 'json'

class Cleaner
  attr_accessor :hash, :unique_keys

  def initialize(json)
    @hash = case json
            when Hash then json
            when String then JSON.parse(json)
            else
              raise "This isn't valide data!"
            end
    @unique_keys = []
  end

  #def purge
  #  @hash.each do |k, v|
  #    if is_collection?(v)
  #      v.map do |obj|
  #        obj.delete_if(&key_exists)
  #      end
  #    end
  #  end
  #end

  def purge hash = @hash
    hash.each do |k, v|
      if @unique_keys.include?(k)
        hash.delete(k)
        next
      else
        @unique_keys << k
        if is_collection?(v)
          v.each do |obj|
            purge obj
          end
        end
      end
    end
  end

  private

  def key_exists
    Proc.new do |k, v|
      if is_collection?(v)
        v.each do |h|
          h.delete_if(&key_exists)
        end
      end
      @unique_keys.include?(k)
    end
  end

  def is_collection?(value)
    return false unless value.is_a?(Array)
    value.all?{ |x| x.is_a?(Hash) }
  end
end
