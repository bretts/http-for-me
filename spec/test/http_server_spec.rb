require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe 'HTTPServer' do

	describe "Requesting A Valid URL" do
		it "should return a 200 response"
		it "should return the page associated with the URL"
	end

	describe "Requesting An Invalid URL" do
		it "should return a 404 response"
	end

	describe "Requesting A File Outside Of The Public Web Root" do
		it "should return the index page"
	end

end