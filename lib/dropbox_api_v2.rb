require "dropbox_api_v2/version"
require "dropbox_api_v2/request"

module DropboxApiV2

  def self.find(path, token, args={})
    Request.new("/files/get_metadata", {path: path, token: token}.merge(args)).response
  end

  def self.list_folder(directory_path, token, args={})
    Request.new("/files/list_folder", {path: directory_path, token: token}.merge(args)).response
  end

  def self.list_folder_continue(cursor, token)
    Request.new("/files/list_folder/continue", cursor: cursor, token: token).response
  end

  def self.download(file_path, token)
    Request.new("/files/download", path: file_path, file_transfer: true, token: token).response
  end

  def self.upload(file_path, token, body)
    Request.new("/files/upload", path: file_path, body: body, file_transfer: true, token: token, mode: :overwrite, mute: true).response
  end

  def self.search(file_path, token, args={})
    Request.new("/files/search", {path: file_path, token: token}.merge(args)).response
  end

  def self.thumbnail(file_path, token, args={})
    Request.new("/files/get_thumbnail", {format: "jpeg", size: "w64h64", path: file_path, token: token, file_transfer: true}.merge(args)).response
  end
end
