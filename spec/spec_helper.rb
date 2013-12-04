require 'net/http'
require 'uri'

ENV['testing_http_for_me'] = 'true'
require File.expand_path('../http_for_me', File.dirname(__FILE__))

RSpec.configure do |rspec|
	rspec.fail_fast = true

	# assume that http_for_me is already running
	rspec.before(:all) do
		uri = URI.parse("http://#{Configuration::SERVER[:host]}:#{Configuration::SERVER[:port]}/index.html")

		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Get.new(uri.request_uri)

		begin
			response = http.request(request)
		rescue Errno::ECONNREFUSED
			raise "You need to start the http_for_me server before running the tests. Go to the http_for_me folder and run ruby 'http_for_me.rb'"
		end
	end
end

# a helper function that a gets a response from a get request
# ==== Example
# get_response("http://#{Configuration::SERVER[:host]}:#{Configuration::SERVER[:port]}/index.html")
def get_response(url)
	uri = URI.parse(url)

	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)

	return http.request(request)
end