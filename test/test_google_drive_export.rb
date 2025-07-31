# test/test_google_drive_export.rb

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'yaml'

require 'rubygems'
require 'bundler/setup'
require 'highline'
require 'test/unit'

require 'google_drive'
require_relative 'test_helper'

class TestGoogleDriveExport < Test::Unit::TestCase
  include(SessionHelper)

  def test_upload_and_download
    session = get_session
    return unless auth_type == AuthType::USER_ACCOUNT
    test_file_path = File.join(File.dirname(__FILE__), 'test_file.txt')
    test_file_title = 'test_file_123.txt'
    file = session.upload_from_file(
      test_file_path, test_file_title, convert: true
    )
    assert { file.is_a?(GoogleDrive::File) }
    assert { file.title == "test_file_123" }
    assert { file.available_content_types == [] }
    assert { file.mime_type == 'application/vnd.google-apps.document' }
    download_path = File.join(File.dirname(__FILE__), 'sample-epub-file-dl.epub')
    file.export_as_file(download_path)
    assert { File.exist?(download_path) }
    File.delete(download_path)
  end
end