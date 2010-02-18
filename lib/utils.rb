ROOT_DIR = ::File.expand_path(::File.join(::File.dirname(__FILE__), ".."))
require ROOT_DIR + "/lib/uuid"
require 'uri'
require 'net/http'

def time(name="Method")
  start = Time.now
  yield
  puts "#{name} execution time: #{Time.now - start}s"
end

def gen_uuid
  UUID.create.to_s.gsub('-','')  
end

def http_delete(url)
  url = URI.parse(url)
  req = Net::HTTP::Delete.new(url.path)
  response = Net::HTTP.new(url.host, url.port).start { |http| http.request(req) }
end
