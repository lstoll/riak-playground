require 'riak'
require '../lib/utils.rb'

# Connect and get a bucket instance
client = Riak::Client.new
bucket = client.bucket("test4", :keys => false) # we don't want to load all the keys!

time "Traverse 1 links" do 
  # Grab a starting point, and walk
  obj = bucket.get('1000')

  p obj.walk(:bucket => bucket.name, :tag => 'parent')
end

time "Traverse 5 links" do 
  # Grab a starting point, and walk
  obj = bucket.get('15000')

  # One doesn't do it like this, because you can't (seemingly) run link-only queries
  #puts Riak::MapReduce.new(client).add(bucket.name).
  #  link(:tag => 'parent').
  #  link(:tag => 'parent', :keep => true).run

  # Instead, like this. Neato, can just keep adding them
  p obj.walk(:bucket => bucket.name, :tag => 'parent')

  # Could build this easier, but want to make a point.
  p obj.walk({:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'})
end

time "Traverse 10 links" do 
  # Grab a starting point, and walk
  obj = bucket.get('10000')

  p obj.walk({:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'})
end

time "Traverse 50 links" do 
  # Grab a starting point, and walk
  obj = bucket.get('5000')

  # One doesn't do it like this, because you can't (seemingly) run link-only queries
  #puts Riak::MapReduce.new(client).add(bucket.name).
  #  link(:tag => 'parent').
  #  link(:tag => 'parent', :keep => true).run

  # Instead, like this. Neato, can just keep adding them
  p obj.walk(:bucket => bucket.name, :tag => 'parent')

  # Could build this easier, but want to make a point.
  p obj.walk({:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'},
              {:bucket => bucket.name, :tag => 'parent'})
end

