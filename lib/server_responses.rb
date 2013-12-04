module ServerResponses

	def respond_with_200(file_path, socket)
		File.open(file_path, "rb") do |file|
			socket.print "HTTP/1.1 200 OK\r\n" +
				 "Content-Type: #{get_content_type(file)}\r\n" +
				 "Content-Length: #{file.size}\r\n" +
				 "Connection: close\r\n"

			socket.print "\r\n"

			IO.copy_stream(file, socket)
		end
	end

	def respond_with_404(socket)
		message = "File not found\n"

		socket.print "HTTP/1.1 404 Not Found\r\n" +
					 "Content-Type: text/plain\r\n" +
					 "Content-Length: #{message.size}\r\n" +
					 "Connection: close\r\n"

		socket.print "\r\n"

		socket.print message
	end

end