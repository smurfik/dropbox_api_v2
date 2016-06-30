require 'json'

module DropboxApiV2
  class Response
    def initialize(curl_response)
      @curl_response = curl_response
    end

    def json
      JSON.parse(body)
    end

    def body
      @curl_response.body
    end

    def cursor
      json["cursor"]
    end
  end
end
