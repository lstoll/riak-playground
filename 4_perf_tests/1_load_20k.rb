require 'riak'
require 'json'
require '../lib/utils'

# Connect and get a bucket instance
client = Riak::Client.new
puts "** Loading bucket **"
bucket = nil
time ("Bucket load (get all keys)") { bucket = client.bucket("test4") }
puts "** Bucket with #{bucket.keys.size} loaded **"

# Delete all - horribly inefficiant, try an erl map fun later.
puts "** Deleting keys"
delcounter = 1
time "Delete all keys" do
  bucket.keys.each do |k| 
    puts "Deleted #{delcounter} entries" if delcounter % 1000 == 0
    # the lazy way
    # bucket.get(k).delete
    http_delete(
      "http://#{client.host}:#{client.port}/#{client.prefix}/#{bucket.name}/#{k}")
    delcounter += 1
  end
end

prev = nil

puts "** Inserting 20k items **"
time "Insert 20k items" do
  (1..20000).each do |i|
    puts "Saving item #{i}" if i % 1000 == 0
    o = Riak::RObject.new(bucket, i)
    o.content_type = "application/javascript"
    o.data = {:item => 'one', :batch => i / 10}.to_json
    o.links << prev.to_link("parent") if prev
    o.store
    prev = o
  end
end
