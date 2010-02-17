require 'riak'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test4")

prev = nil

(1..100000).each do |i|
  puts "Saving item #{i}" if i % 10 == 0
  o = Riak::RObject.new(bucket, i)
  o.content_type = "application/javascript"
  o.data = "{'item': 'one'}"
  o.links << prev.to_link("parent") if prev
  o.store
  prev = o
end
