require 'riak'
require 'json'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test4")

prev = nil

(1..20000).each do |i|
  puts "Saving item #{i}" if i % 10 == 0
  o = Riak::RObject.new(bucket, i)
  o.content_type = "application/javascript"
  o.data = {:item => 'one', :batch => 111 / 10}.to_json
  o.links << prev.to_link("parent") if prev
  o.store
  prev = o
end
