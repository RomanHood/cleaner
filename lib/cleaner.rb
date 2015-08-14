require 'json'
require 'pp'

class Cleaner
  attr_accessor :hash

  def initialize(json)
    @hash = case json
            when Hash then json
            when String then JSON.parse(json)
            else
              raise "This isn't valide data!"
            end
    @unique_keys = []
  end

  def purge hash = @hash, keys = @hash.keys
    hash.each do |k, v|
      @unique_keys << k
      purge_hashes(v, keys) if is_collection?(v)
    end
  end

  def unique_keys
    @unique_keys.uniq
  end

  private
  def purge_hashes collection, keys
    collection.each do |document|
      ke = key_exists keys
      document.delete_if(&ke)
      stacked_keys = keys | document.keys
      purge document, stacked_keys
    end
  end

  def key_exists keys
    Proc.new do |k, v|
      keys.include?(k)
    end
  end

  def is_collection?(value)
    return false unless value.is_a?(Array)
    value.all?{ |x| x.is_a?(Hash) }
  end
end
