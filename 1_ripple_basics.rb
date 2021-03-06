require 'riak'
require 'lib/utils'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test1")

# Ensure bucket is empty. When bugfixed, pass block direct to bucket
bucket.keys.each {|k| bucket.get(k).delete}

# Create and save a simple JSON object
new_one = Riak::RObject.new(bucket, gen_uuid)
new_one.content_type = "application/json" # You must set the content type.
new_one.data = "{'item': 'one'}"
new_one.store

# Create and save a simple JSON object
new_two = Riak::RObject.new(bucket, gen_uuid)
new_two.content_type = "application/json" # You must set the content type.
new_two.data = "{'item': 'two'}"
new_two.store


# The above MP doesn't work anyway - backends need tweaking. DO this the old way
# instead

# Print bucket contents
#bucket.keys {|k| p bucket.get(k)}

# Empty Bucket
#bucket.keys {|k| bucket.get(k).delete}

keys = bucket.keys(:reload => true)

keys.each {|k| p bucket.get(k)}
keys.each {|k| bucket.get(k).delete}
