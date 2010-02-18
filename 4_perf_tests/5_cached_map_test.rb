###
# This one requires some setup! You need a line like
#
# {js_source_dir, "/usr/local/var/lib/riak-js"}
#
# in
#
# /usr/local/Cellar/riak/0.8/etc/app.config
#
# You will then need to copy 5_cached.js into that dir.

require 'riak'
require '../lib/utils.rb'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test4", :keys => false) # we don't want to load all the keys!

time "Simple map - Select 10 by batch (Server function)" do 
  puts Riak::MapReduce.new(client).add(bucket.name).
    map(:function => "FourFiveCachedTest", :keep => true).run
end


