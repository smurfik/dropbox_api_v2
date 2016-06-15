require 'json'

module DropboxApiV2
  class Response
    def initialize(curl_response)
      @curl_response = curl_response
    end

    def body
      JSON.parse(@curl_response.body)
    end
  end
end
