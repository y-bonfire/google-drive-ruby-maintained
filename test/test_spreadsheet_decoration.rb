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

  def test_hyperlink
    session = get_session
    spreadsheet_id = ENV['GOOGLE_DRIVE_TEST_SPREADSHEET_ID']
    spreadsheet = session.spreadsheet_by_key(spreadsheet_id)
    worksheet = spreadsheet.worksheets.first
    worksheet.set_hyperlink_rich(1,1,1,1, "google", "https://www.google.com/")
    # another way
    worksheet[2,1].set_hyperlink_rich("gemini", "https://gemini.google.com/")

    # It seems that you can't set a value and a link to a cell
    # with the same index at the same time, probably because of
    # duplicate requests.
    #worksheet[2,1] = "gemini"
    #worksheet[2,1].hyperlink = "https://gemini.google.com/app?hl=ja"
    
    worksheet.save
    worksheet.reload

    assert{worksheet[1,1].hyperlink == "https://www.google.com/"}
    assert{worksheet[2,1].hyperlink == "https://gemini.google.com/"}
  end

end
