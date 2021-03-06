require File.expand_path('server_requests.rb', File.dirname(__FILE__))
require File.expand_path('server_responses.rb', File.dirname(__FILE__))

require 'socket'
require 'uri'

class HTTPServer
	extend ServerRequests
	extend ServerResponses

	def self.start_server
		puts "Starting to listen for http requests at: http://#{Configuration::SERVER[:host]}:#{Configuration::SERVER[:port]}"
		
		server = TCPServer.new(Configuration::SERVER[:host], Configuration::SERVER[:port])

		loop do
			Thread.start(server.accept) do |socket|
				puts "\nwaiting for incoming request: #{Time.now.to_s}"
				
				request_line = socket.gets

				next if request_line.nil? #don't crash if there is an empty request		

				puts request_line

				path = get_requested_file_path(request_line)

				if File.exists?(path) && !File.directory?(path)
					respond_with_200(path, socket)
				else
					respond_with_404(socket)
				end
				
				socket.close
			end
		end
	end
end

HTTPServer.start_server if !ENV['testing_http_for_me']
