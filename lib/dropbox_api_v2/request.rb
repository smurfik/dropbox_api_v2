require 'curb'
require 'json'
require "dropbox_api_v2/response"

module DropboxApiV2
  class Request
    attr_reader :path, :verb

    API_URL     = "https://api.dropboxapi.com/2"
    CONTENT_URL = "https://content.dropboxapi.com/2"

    def initialize(path, params={})
      @path          = path
      @token         = params.delete(:token)
      @body          = params.delete(:body)
      @file_transfer = params.delete(:file_transfer)
      @params        = params
    end

    def base_url
      file_transfer? ? CONTENT_URL : API_URL
    end

    def url
      base_url + path
    end

    def json_params
      @params.to_json
    end

    def upload?
      file_transfer? && @body
    end

    def download?
      file_transfer? && !@body
    end

    def file_transfer?
      @file_transfer
    end


    def content_type
      if upload?
        "application/octet-stream"
      elsif download?
        ""
      else
        "application/json"
      end
    end

    def headers
      headers = {"Authorization": "Bearer #{@token}", "Content-Type": content_type}
      headers["Dropbox-API-Arg"] = json_params if file_transfer?
      headers
    end

    def response
      DropboxApiV2::Response.new perform
    end

    def body
      file_transfer? ? @body : json_params
    end

    def perform
      Curl.post(url, body) do |http|
        http.headers = headers
      end
    end
  end
end
