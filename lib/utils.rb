ROOT_DIR = ::File.expand_path(::File.join(::File.dirname(__FILE__), ".."))
require ROOT_DIR + "/lib/uuid"

def time(name="Method")
  start = Time.now
  yield
  puts "#{name} execution time: #{Time.now - start}"
end

def gen_uuid
  UUID.create.to_s.gsub('-','')  
end
