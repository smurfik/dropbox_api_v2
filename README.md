# DropboxApiV2

A Ruby client for the Dropbox API V2.

Current state: First release, includes methods listed below:

* list_folder
* list_folder_continue
* download
* upload
* search

## Installation

In your Gemfile:

```ruby
gem 'dropbox_api_v2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dropbox_api_v2

## Usage

```ruby
DropboxApiV2.list_folder(directory_path, token, args={})
  example: folder_contents = DropboxApiV2.list_folder("/directory name", "dropbox_token", recursive: true)
  # the methods `json, body, cursor` are avaible for all calls
           folder_contents.json   #returns response in the json form
           folder_contents.body   #returns raw response
           folder_contents.cursor #returns cursor to be used in the future
DropboxApiV2.list_folder_continue(cursor, token)
  example: folder_contents = DropboxApiV2.list_folder_continue("cursor_from_previous_call", "dropbox_token")
DropboxApiV2.download(file_path, token)
  example: contents_of_file = DropboxApiV2.download("/path/to_file.txt", "dropbox_token")
DropboxApiV2.upload(file_path, token, body)
  example: upload_file = DropboxApiV2.upload("/path/new_file.txt", "dropbox_token", "content_to_write_in_the_file")
DropboxApiV2.search(file_path, token, args={})
  example: files_found = DropboxApiV2.search("/", "dropbox_token", query: "file_name")
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smurfik/dropbox_api_v2.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
