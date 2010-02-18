require 'riak'
require '../lib/utils.rb'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test4", :keys => false) # we don't want to load all the keys!

time "Simple map - Select 10 by batch" do 
  puts Riak::MapReduce.new(client).add(bucket.name).
    map("function(v) {
          // Load the items data, and parse it
          obj = JSON.parse(v.values[0].data);
          if (obj.batch && obj.batch == '513') {
            return [obj];
          }
          else {
            return []; 
          }
        }", :keep => true).run
end


