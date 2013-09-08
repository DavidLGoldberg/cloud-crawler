require 'spec_helper'
require 'pp'

module CloudCrawler
  describe HTTP do

    describe "fetch_page" do
      before(:each) do
        FakeWeb.clean_registry
      end

      it "should still return a Page if an exception occurs during the HTTP connection" do
        HTTP.stub!(:refresh_connection).and_raise(StandardError)
        http = CloudCrawler::HTTP.new
        http.fetch_page(SPEC_DOMAIN).should be_an_instance_of(Page)
      end

      it "should crawl a javascript page and execute the headless browser." do
          # ARRANGE:
          opts = { :headless => true }
          http = CloudCrawler::HTTP.new opts
          expected_response = {
                                                          #:get => "http://example.com",
                                                          #:redirected => false,
              :code => "200"
          }
          expected_response = OpenStruct.new expected_response

          # ACT:
          response, response_time = http.fetch_pages("http://example.com")

          # ASSERT:
                                                          #response.redirected.to_b.should == expected_response.redirected
          pp response
          puts "CODE::: #{response.code}"
          response.code.should == expected_response.code.to_i # The calling code converts from string to int
          response_time.to_i.should be < 10
      end
    end
  end
end
