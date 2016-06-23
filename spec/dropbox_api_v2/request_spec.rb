require 'spec_helper'

describe DropboxApiV2::Request do

  describe "#base_url" do
    context "when file_transfer set to true" do
      it "returns CONTENT_URL" do
        request = DropboxApiV2::Request.new("/", file_transfer: true)
        expect(request.base_url).to eq("https://content.dropboxapi.com/2")
      end
    end
    context "when file_transfer set isn't present" do
      it "returns API_URL" do
        request = DropboxApiV2::Request.new("/")
        expect(request.base_url).to eq("https://api.dropboxapi.com/2")
      end
    end
  end

  describe "#url" do
    it "concatenates base_url and path" do
      request = DropboxApiV2::Request.new("/path_example")
      expect(request.url).to eq ("https://api.dropboxapi.com/2/path_example")
    end
  end

  describe "#json_params" do
    it "returns params as json" do
      request = DropboxApiV2::Request.new("/path_example", path: "/my_folder")
      expect(request.json_params).to eq "{\"path\":\"/my_folder\"}"
    end
  end

  describe "#upload?" do
    it "if @body isn't set it returns false" do
      request = DropboxApiV2::Request.new("/path_example", file_transfer: true)
      expect(request.upload?).to eq false
    end
    it "if file_transfer isn't set it returns false" do
      request = DropboxApiV2::Request.new("/path_example", body: "sunny body")
      expect(request.upload?).to eq false
    end
    it "if file_transfer and body are present it returns true" do
      request = DropboxApiV2::Request.new("/path_example", body: "sunny body", file_transfer: true)
      expect(request.upload?).to eq true
    end
  end

  describe "#download?" do
    it "if @body isn't set it returns true" do
      request = DropboxApiV2::Request.new("/path_example", file_transfer: true)
      expect(request.download?).to eq true
    end
    it "if file_transfer isn't set it returns false" do
      request = DropboxApiV2::Request.new("/path_example", body: "sunny body")
      expect(request.download?).to eq false
    end
    it "if file_transfer and body are present it returns false" do
      request = DropboxApiV2::Request.new("/path_example", body: "sunny body", file_transfer: true)
      expect(request.download?).to eq false
    end
  end

  describe "#content_type" do
    context "when upload? is truthy" do
      it "returns 'application/octet-stream'" do
        request = DropboxApiV2::Request.new("/path_example", body: "sunny body", file_transfer: true)
        expect(request.content_type).to eq "application/octet-stream"
      end
    end
    context "when download? is truthy" do
      it "returns empty string" do
        request = DropboxApiV2::Request.new("/path_example", file_transfer: true)
        expect(request.content_type).to eq ""
      end
    end
    context "when download? and upload? falsey" do
      it "returns 'application/json'" do
        request = DropboxApiV2::Request.new("/path_example")
        expect(request.content_type).to eq "application/json"
      end
    end
  end

  describe "#headers" do
    it "returns headers" do
      request = DropboxApiV2::Request.new("/path_example", token: "123", recursive: true, file_transfer: true)
      expect(request.headers).to include "Authorization": "Bearer 123"
      expect(request.headers).to include "Dropbox-API-Arg" => "{\"recursive\":true}"
    end
  end

  describe "#body" do
    context "when file_transfer? set to true" do
      it "returns @body" do
        request = DropboxApiV2::Request.new("/path_example", file_transfer: true, body: "sunny body")
        expect(request.body).to eq "sunny body"
      end
    end
    context "when file_transfer? set to false" do
      it "returns json_params" do
        request = DropboxApiV2::Request.new("/path_example", recursive: true)
        expect(request.body).to eq "{\"recursive\":true}"
      end
    end
  end

  describe "#perform" do
    it "returns an instance of Curl" do
      request = DropboxApiV2::Request.new("/path_example", path: "/my_folder")
      expect(request.perform).to be_an_instance_of(Curl::Easy)
    end
  end

  describe "#response" do
    it "returns an instance of Response" do
      request = DropboxApiV2::Request.new("/path_example", path: "/my_folder")
      expect(request.response).to be_an_instance_of(DropboxApiV2::Response)
    end
  end
end
