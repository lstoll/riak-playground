require 'riak'
require '../lib/utils.rb'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test4", :keys => false) # we don't want to load all the keys!

time "Simple sum M/R" do 
  puts Riak::MapReduce.new(client).
                add(bucket.name).
                map("function(v) { return [1]; }"). # just a count of items
                reduce("Riak.reduceSum", :keep => true).run # sum them all
end

