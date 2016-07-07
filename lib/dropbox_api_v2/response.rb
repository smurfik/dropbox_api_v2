require 'json'

module DropboxApiV2
  class Response
    attr_reader :raw_response
    def initialize(curl_response)
      @raw_response = curl_response
    end

    def json
      JSON.parse(body)
    end

    def body
      @raw_response.body
    end

    def cursor
      json["cursor"]
    end
  end
end
