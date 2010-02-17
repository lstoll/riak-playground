require 'riak'
require 'uuid'

def gen_id
  UUID.create.to_s.gsub('-','')  
end

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test2")

# Ensure bucket is empty. When bugfixed, pass block direct to bucket
bucket.keys.each {|k| bucket.get(k).delete}

# Create and save a simple JSON object
new_one = Riak::RObject.new(bucket, "item1")
new_one.content_type = "application/json" # You must set the content type.
new_one.data = "{'item': 'one'}"
new_one.store

# Create and save a second JSON object, linking to the first
new_two = Riak::RObject.new(bucket, "item2")
new_two.content_type = "application/json" # You must set the content type.
new_two.data = "{'item': 'two'}"
# Linking. Must be a better way to create the URL?. Link is tagged parent
new_two.links << new_one.to_link("parent")
new_two.store

p "** Walk the Parent Link **"
p new_two.walk(:tag => 'parent')

keys = bucket.keys(:reload => true)

puts "*** All items in bucket ***"
bucket.keys.each {|k| i =  bucket.get(k) ; p i ; p i.links}
#bucket.keys.each {|k| bucket.get(k).delete}

