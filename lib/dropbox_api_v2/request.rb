require 'curb'
require 'json'
require "dropbox_api_v2/response"

module DropboxApiV2
  class Request
    attr_reader :path, :verb
    URL = "https://api.dropboxapi.com/2"
    def initialize(path, token, params={})
      @path = path
      @token = token
      @params = params
    end

    def url
      URL + path
    end

    def json_params
      @params.to_json
    end

    def headers
      {
        "Authorization" => "Bearer #{@token}",
        "Content-Type"  => "application/json"
      }
    end

    def response
      DropboxApiV2::Response.new perform
    end

    def perform
      Curl.post(url, json_params) do |http|
        http.headers = headers
      end
    end
  end
end
