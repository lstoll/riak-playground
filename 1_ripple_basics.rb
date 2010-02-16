require 'riak'
require 'uuid'

def gen_id
  UUID.create.to_s.gsub('-','')  
end

# Until issue http://github.com/seancribbs/ripple/issues#issue/8 is fixed, force
# the Net::HTTP backend
class Riak::Client
  def http
    @http ||= NetHTTPBackend.new(self)
  end
end

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test1")

# Create and save a simple JSON object
new_one = Riak::RObject.new(bucket, gen_id)
new_one.content_type = "application/json" # You must set the content type.
new_one.data = "{'item': 'one'}"
new_one.store

# Create and save a simple JSON object
new_two = Riak::RObject.new(bucket, gen_id)
new_two.content_type = "application/json" # You must set the content type.
new_two.data = "{'item': 'two'}"
new_two.store


# The above MP doesn't work anyway - backends need tweaking. DO this the old way
# instead

# Print bucket contents
#bucket.keys {|k| p bucket.get(k)}

# Empty Bucket
#bucket.keys {|k| bucket.get(k).delete}

keys = bucket.keys

keys.each {|k| p bucket.get(k)}
keys.each {|k| bucket.get(k).delete}
