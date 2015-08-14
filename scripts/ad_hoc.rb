require 'pry'
require 'awesome_print'

def is_collection?(value)
  return false unless value.is_a?(Array)
  value.all?{ |x| x.is_a?(Hash) }
end

def clean hash
  keys = hash.keys
  p = Proc.new do |k,v|
    if is_collection?(v)
      v.each do |h|
        h.delete_if(&p)
      end
    end
    keys.include?(k)
  end
  hash.each do |k, v|
    if is_collection?(v)
      v.each do |obj|
        obj.delete_if(&p)
      end
    end
  end
end

data = {
  "wholesaler":"US Foods",
  "delivered":"2015-06-19T05:15:00-0500",
  "contacts": [
    {
      "wholesaler":"US Foods",
      "name":"John Lederer"
    },
    {
      "wholesaler":"Sysco",
      "name":"Bill Delaney"
    }
  ]
}
clean data
ap data
