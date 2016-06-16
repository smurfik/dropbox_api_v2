require "dropbox_api_v2/version"
require "dropbox_api_v2/request"

module DropboxApiV2
  def self.list_folder(directory, token, recursive=false)
    Request.new("/files/list_folder", token, {path: directory, recursive: recursive}).response
  end

  def self.list_folder_continue(cursor, token)
    Request.new("/files/list_folder/continue", token, cursor: cursor).response
  end

  def self.download(file_path, token)
    Request.new("/files/download", token, {path: file_path}, true).response
  end

  def self.upload(file_path, token, body)
    Request.new("/files/upload", token, {path: file_path, body: body}, true).response
  end
end
