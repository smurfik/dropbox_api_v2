require 'spec_helper'

describe DropboxApiV2::Response do
  describe '#raw_response' do
    it 'is gettable' do
      response = DropboxApiV2::Response.new('some body')
      expect(response.raw_response).to eq 'some body'
    end
  end
end
