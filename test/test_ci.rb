$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'yaml'
require 'rubygems'
require 'bundler/setup'
require 'highline'
require 'test/unit'
require 'google_drive'

class TestCi < Test::Unit::TestCase
  PREFIX = ''.freeze

  @@session = nil

  def setup
    service_account_path = File.join(File.dirname(__FILE__), 'service_account.json')
    @session = GoogleDrive::Session.from_service_account_key(service_account_path)

    spreadsheet_id = ENV['GOOGLE_DRIVE_TEST_SPREADSHEET_ID']
    raise "Spreadsheet ID missing" unless spreadsheet_id

    @spreadsheet = @session.spreadsheet_by_key(spreadsheet_id)
    @ws = @spreadsheet.worksheets.first
  end

  def test_read_and_write
    original = @ws[1, 1]
    test_value = "CI_TEST_#{Time.now.to_i}"
    @ws[1, 1] = test_value
    @ws.save
    sleep 1
    @ws.reload
    assert { @ws[1, 1] == test_value }
  ensure
    @ws[1, 1] = original
    @ws.save
  end
end