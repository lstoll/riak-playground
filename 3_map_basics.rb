require 'riak'
require 'lib/utils'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test3")

# Ensure bucket is empty. When bugfixed, pass block direct to bucket
bucket.keys.each {|k| bucket.get(k).delete}

# Create and save a simple JSON object
new_one = Riak::RObject.new(bucket, "item1")
new_one.content_type = "application/javascript" # You must set the content type.
new_one.data = '{"item": "one"}'
new_one.store

# Create and save a second JSON object, linking to the first
new_two = Riak::RObject.new(bucket, "item2")
new_two.content_type = "application/javascript" # You must set the content type.
new_two.data = '{"item": "two"}'
# Linking. Must be a better way to create the URL?. Link is tagged parent
new_two.store


puts "*** Simple Query ***"
p Riak::MapReduce.new(client).
                add(bucket.name). # run on all items in bucket
                map("function(v) {
                      // Load the items data, and parse it
                      obj = JSON.parse(v.values[0].data);
                      if (obj.item && obj.item == 'two') {
                        return [obj];
                      }
                      else {
                        return []; 
                      }
                    }",
                    :keep => true).run # Keep make sure we get the output

# This example doesn't achieve anything more than above, but shows how to chain maps
puts "*** Multi Map Phase Query ***"
mr = Riak::MapReduce.new(client).
                add(bucket.name). # run on all items in bucket
                map("function(v) {
                      obj = JSON.parse(v.values[0].data);
                      if (obj.item && obj.item == 'two') {
                        // Need to return bucket/key pairs if the target is another map
                        return [[v.bucket, v.key]];
                      }
                      else {
                        return []; 
                      }
                      
                    }").
                map("function(v) {
                      return [JSON.parse(v.values[0].data)];
                    }", # Just return the JSON representation
                    :keep => true)

p mr.run
