require "dropbox_api_v2/version"
require "dropbox_api_v2/request"

module DropboxApiV2
  def self.list_folder(directory, token, args={})
    Request.new("/files/list_folder", {path: directory, token: token}.merge(args)).response
  end

  def self.list_folder_continue(cursor, token)
    Request.new("/files/list_folder/continue", cursor: cursor, token: token).response
  end

  def self.download(file_path, token)
    Request.new("/files/download", path: file_path, file_transfer: true, token: token).response
  end

  def self.upload(file_path, token, body)
    Request.new("/files/upload", path: file_path, body: body, file_transfer: true, token: token).response
  end
end
