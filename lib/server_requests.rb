require 'uri'

module ServerRequests

	CONTENT_TYPE_MAPPING = {
		'html' => 'text/html',
		'txt' => 'text/plain',
		'png' => 'image/png',
		'jpg' => 'image/jpeg',
		'css' => 'text/css'
	}

	DEFAULT_CONTENT_TYPE = 'application/octet-stream'


	def get_content_type(path)
		ext = File.extname(path).split('.').last
		CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
	end

	def get_requested_file_path(get_request)
		return if get_request.nil?

		request_uri  = get_request.split(" ")[1]
		path         = URI.unescape(URI(request_uri).path)
		path 		 = File.join(path, 'index.html') if File.directory?(path)

		requested_file = File.join(Configuration::WEB_ROOT, path)

		puts "requested_file: #{requested_file}"

		# ensure the user is not requesting a file outside of the webroot
		if(requested_file.split('/').include?('..'))
			# return the index file if they are trying to get a file outside of the public folder
			return File.join(Configuration::WEB_ROOT, 'index.html')
		else
			return requested_file
		end
	end

end