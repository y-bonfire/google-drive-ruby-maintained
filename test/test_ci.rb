$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'yaml'
require 'rubygems'
require 'bundler/setup'
require 'highline'
require 'test/unit'
require 'google_drive'
require_relative 'test_helper'

class TestCi < Test::Unit::TestCase
  def setup
    service_account_path = File.join(File.dirname(__FILE__), 'service_account.json')
    @session = GoogleDrive::Session.from_service_account_key(service_account_path)

    spreadsheet_id = ENV['GOOGLE_DRIVE_TEST_SPREADSHEET_ID']
    dst_spreadsheet_id = ENV['DST_GOOGLE_DRIVE_TEST_SPREADSHEET_ID']
    raise "Spreadsheet ID missing" unless spreadsheet_id
    raise "Destination Spreadsheet ID missing" unless dst_spreadsheet_id

    @spreadsheet = @session.spreadsheet_by_key(spreadsheet_id)
    @worksheet = @spreadsheet.worksheets.first
    @dst_spreadsheet = @session.spreadsheet_by_key(dst_spreadsheet_id)
  end

  def test_read_and_write
    original = @worksheet[1, 1]
    test_value = "CI_TEST_#{Time.now.to_i}"
    @worksheet[1, 1] = test_value
    @worksheet.save
    sleep 1
    @worksheet.reload
    assert { @worksheet[1, 1] == test_value }
  ensure
    @worksheet[1, 1] = original
    @worksheet.save
  end

  def test_copy_to
    @worksheet.reload
    @worksheet[1, 1] = 'A'
    @worksheet[1, 2] = 'B'
    @worksheet[2, 1] = '1'
    @worksheet[2, 2] = '2'
    @worksheet.save

    @worksheet.copy_to(@dst_spreadsheet.id)
    @worksheet.reload

    last_work_sheet = @dst_spreadsheet.worksheets.last
    assert { last_work_sheet.sheet_id == last_work_sheet.sheet_id }
    assert { last_work_sheet.title == last_work_sheet.title }

    assert { last_work_sheet[1, 1] == 'A' }
    assert { last_work_sheet[1, 2] == 'B' }
    assert { last_work_sheet[2, 1] == '1' }
    assert { last_work_sheet[2, 2] == '2' }

    (@dst_spreadsheet.worksheets[1..-1] || []).each do |sheet|
      sheet.delete
    end
    @dst_spreadsheet.worksheets[0].reload
  end
end