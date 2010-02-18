require 'riak'
require 'lib/utils'
require 'pp'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test5")

# Ensure bucket is empty. When bugfixed, pass block direct to bucket
bucket.keys.each {|k| bucket.get(k).delete}

puts "** Create two dummy objects **"
# Create and save a simple JSON object
new_one = Riak::RObject.new(bucket, "item1")
new_one.content_type = "application/json" # You must set the content type.
new_one.data = "{'item': 'one'}"
new_one.store

# Create and save a second JSON object, linking to the first
new_two = Riak::RObject.new(bucket, "item2")
new_two.content_type = "application/json" # You must set the content type.
new_two.data = "{'item': 'two'}"
new_two.store

puts "** Create a third object, linking to the first two as 'parent' **"
new_three = Riak::RObject.new(bucket, "item3")
new_three.content_type = "application/json" # You must set the content type.
new_three.data = "{'item': 'three'}"
new_three.links << new_one.to_link("parent")
new_three.links << new_two.to_link("parent")
new_three.store

p "** Walk the Parent Link **"
pp new_three.walk(:tag => 'parent')

p "** Remove one of the links **"
# reload for good measure
new_three = bucket.get("item3")
new_three.links.shift
new_three.store

p "** Walk the Parent Link again **"
pp new_three.walk(:tag => 'parent')

