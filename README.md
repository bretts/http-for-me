HTTP For Me
===========

PURPOSE
-------
This is a little HTTP server built purely for interest sake after reading an article by Luke Francl about implementing a minmal HTTP server 
on practicingruby.com. The intention here is just to learn more and have fun while doing so.

FEATURES
--------
While not a fully function HTTP server, this currently supports some basic functionality like GET requests with 200 and 404 responses


EXAMPLE USAGE
-------------
		require 'http_for_me'

		# do a quick request against the server
		require 'net/http'
		require 'uri'
		puts Net::HTTP.get(URI.parse(http://localhost/index.html))