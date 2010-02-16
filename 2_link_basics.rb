####
# NOT CURRENTLY WORKING - RIAK IS THROWING A 500 ON THE QUERY
# Running the 'same' by hand (e.g)
# curl http://127.0.0.1:8098/raw/test1/852120fe1b2f11df7b81f9cd003fb038/test1,parent,1
# Is working
###


require 'riak'
require 'uuid'

def gen_id
  UUID.create.to_s.gsub('-','')  
end

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test1")

# Create and save a simple JSON object
new_one = Riak::RObject.new(bucket, gen_id)
new_one.content_type = "application/json" # You must set the content type.
new_one.data = "{'item': 'one'}"
new_one.store

# Create and save a second JSON object, linking to the first
new_two = Riak::RObject.new(bucket, gen_id)
new_two.content_type = "application/json" # You must set the content type.
new_two.data = "{'item': 'two'}"
# Linking. Must be a better way to create the URL?. Link is tagged parent
new_two.links << Riak::Link.new("/raw/#{bucket.name}/#{new_two.key}", "parent")
new_two.store

# Walk the link. We start the walk from new_two, and limit the walk to the current
# bucket, and traverse links tagged parent. The last item on the list needs 
# keep => true, to return the results
mr = Riak::MapReduce.new(client).add("test1", new_two.key).link(:bucket => 'test1',
                                                   :tag => 'parent', :keep => true)
puts "** Query JSON ***"
puts mr.to_json
puts "*** Results of link query ***"
p mr.run

keys = bucket.keys

puts "*** All items in bucket ***"
keys.each {|k| p bucket.get(k)}
keys.each {|k| bucket.get(k).delete}

