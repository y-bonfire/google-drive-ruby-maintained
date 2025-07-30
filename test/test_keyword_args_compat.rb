# test/test_keyword_args_compat.rb

# These tests ensure compatibility with Ruby 2.7+ keyword arguments.
# Specifically, they check for warnings or errors when passing hash-style args.
#
# See: https://bugs.ruby-lang.org/issues/14183

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'yaml'

require 'rubygems'
require 'bundler/setup'
require 'highline'
require 'test/unit'

require 'google_drive'
require_relative 'test_helper'

class TestKeywordArgsCompat < Test::Unit::TestCase
  include(SessionHelper)

  def test_upload_and_download
    session = get_session
    test_file_path = File.join(File.dirname(__FILE__), 'test_file.txt')
    test_file_title = "test_file-12345.txt"
    file = session.upload_from_file(
      test_file_path, test_file_title, convert: false
    )
    assert { file.is_a?(GoogleDrive::File) }
    assert { file.title == test_file_title }
    assert { file.available_content_types == ['text/plain'] }
    assert { file.download_to_string == File.read(test_file_path) }

    download_path = File.join(File.dirname(__FILE__), 'test_file_downloaded.txt')
    file = session.file_by_title(test_file_title)
    file.download_to_file(download_path)
    assert { File.exist?(download_path) }
    File.delete(download_path)
  end
end