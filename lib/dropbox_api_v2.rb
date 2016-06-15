require "dropbox_api_v2/version"
require "dropbox_api_v2/request"

module DropboxApiV2
  def self.list_folder(directory, token)
    Request.new("/files/list_folder", token, path: directory).response
  end
end
