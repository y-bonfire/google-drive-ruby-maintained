# test/test_spreadsheet_decoration.rb

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'yaml'

require 'rubygems'
require 'bundler/setup'
require 'highline'
require 'test/unit'

require 'google_drive'
require_relative 'test_helper'

class TestSpreadsheetDecoration < Test::Unit::TestCase
  include(SessionHelper)

  def test_border
    session = get_session
    spreadsheet_id = ENV['GOOGLE_DRIVE_TEST_SPREADSHEET_ID']
    spreadsheet = session.spreadsheet_by_key(spreadsheet_id)
    worksheet = spreadsheet.worksheets.first
    border = { bottom: Google::Apis::SheetsV4::Border.new(
      style: "DOUBLE", color: GoogleDrive::Worksheet::Colors::RED) }
    worksheet.update_borders(1, 1, 1, 1, border)
    worksheet.save
  end

end
