require 'curb'
require 'json'
require "dropbox_api_v2/response"

module DropboxApiV2
  class Request
    attr_reader :path, :verb
    API_URL = "https://api.dropboxapi.com/2"
    CONTENT_URL = "https://content.dropboxapi.com/2"
    def initialize(path, token, params={}, header_params=false)
      @path = path
      @token = token
      @params = params
      @body = params.delete(:body)
      @header_params = header_params
    end

    def url
      if @header_params
        CONTENT_URL + path
      else
        API_URL + path
      end
    end

    def json_params
      @params.to_json
    end

    def headers
      headers = {"Authorization" => "Bearer #{@token}"}
      if @header_params
        headers["Dropbox-API-Arg"] = json_params
        if @body
          headers["Content-Type"] = "application/octet-stream"
        else
          headers["Content-Type"] = ""
        end
      else
        headers["Content-Type"] = "application/json"
      end
      headers
    end

    def response
      DropboxApiV2::Response.new perform
    end

    def body
      if @header_params
        @body
      else
        json_params
      end
    end

    def perform
      Curl.post(url, body) do |http|
        http.headers = headers
      end
    end
  end
end
