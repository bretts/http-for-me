require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe 'HTTPServer' do

	describe "Requesting A Valid URL" do
		before(:all) do
			@response = get_response("http://#{Configuration::SERVER[:host]}:#{Configuration::SERVER[:port]}/index.html")
		end

		it "should return a 200 response" do
			@response.code.should == "200"
		end

		it "should return the page associated with the URL" do
			puts @response.body.should =~ /test index page/			
		end
	end

	describe "Requesting An Invalid URL" do
		before(:all) do
			@response = get_response("http://#{Configuration::SERVER[:host]}:#{Configuration::SERVER[:port]}/no_file_here.html")
		end

		it "should return a 404 response" do
			@response.code.should == "404"
		end
	end

	describe "Requesting A File Outside Of The Public Web Root" do
		before(:all) do
			@response = get_response("http://#{Configuration::SERVER[:host]}:#{Configuration::SERVER[:port]}/../../my_passwords.txt")
		end

		it "should return a 200 response" do
			@response.code.should == "200"
		end

		it "should return the index page" do
			#don't allow users access to anything outside of the public root folder in order to protect security
			puts @response.body.should =~ /test index page/			
		end		
	end

end