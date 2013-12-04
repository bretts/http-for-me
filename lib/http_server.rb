require File.expand_path('server_requests.rb', File.dirname(__FILE__))
require File.expand_path('server_responses.rb', File.dirname(__FILE__))

require 'socket'
require 'uri'

class HTTPServer
	include ServerRequests
	include ServerResponses

	def self.start_server
		server = TCPServer.new(Configuration::SERVER[:host], Configuration::SERVER[:port])

		#@@server_started = true

		loop do
			puts "\nwaiting for incoming request: #{Time.now.to_s}"
			socket = server.accept

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

#HTTPServer.start_server