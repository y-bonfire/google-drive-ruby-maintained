# test/session_helper.rb
require 'google_drive'

CREATE_ACCOUNT_MESSAGE = <<~MSG.freeze
  This test will create files/spreadsheets/collections with your account, read/write them and finally delete them (if everything succeeds).'
MSG
DEPRECATED_ACCOUNT_MESSAGE_TEMPLATE = <<~MSG.freeze
  %s is deprecated. Please delete it.
  Instead, follow one of the instructions here to create either config.json or a service account key JSON file and put it at %s:
  https://github.com/gimite/google-drive-ruby/blob/master/README.md#how-to-use
MSG
MISSING_CONFIG_MESSAGE_TEMPLATE = <<~MSG.freeze
  %s is missing.
  Follow one of the instructions here to create either config.json or a service account key JSON file and put it at %s:
  https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
MSG

module AuthType
  SERVICE_ACCOUNT = 'service_account'
  USER_ACCOUNT = 'user_account'
end

module SessionHelper
  @@session = nil

  def auth_type
    ENV['GOOGLE_DRIVE_AUTH_TYPE'] || AuthType::USER_ACCOUNT
  end

  # @return [GoogleDrive::Session]
  def get_session
    unless @@session
      puts CREATE_ACCOUNT_MESSAGE
      case auth_type
      when AuthType::SERVICE_ACCOUNT
        puts "test execute by service_account mode. cannot create/delete files"
      when AuthType::USER_ACCOUNT
        puts "test execute by user_account mode"
      else
        raise "Unsupported GOOGLE_DRIVE_AUTH_TYPE: #{ENV['GOOGLE_DRIVE_AUTH_TYPE']}"
      end
    end
    account_path = File.join(File.dirname(__FILE__), 'account.yaml')
    config_path = File.join(File.dirname(__FILE__), 'config.json')
    service_account_path = File.join(File.dirname(__FILE__), 'service_account.json')
    if File.exist?(account_path)
      raise(format(DEPRECATED_ACCOUNT_MESSAGE_TEMPLATE, account_path, config_path))
    end
    @@session ||= begin
                    case auth_type
                    when AuthType::SERVICE_ACCOUNT
                      GoogleDrive::Session.from_service_account_key(service_account_path)
                    when AuthType::USER_ACCOUNT, nil
                      unless File.exist?(config_path)
                        raise(format(MISSING_CONFIG_MESSAGE_TEMPLATE, config_path, config_path))
                      end
                      GoogleDrive::Session.from_config(config_path)
                    else
                      raise "Unsupported GOOGLE_DRIVE_AUTH_TYPE: #{ENV['GOOGLE_DRIVE_AUTH_TYPE']}"
                    end
                  end
  end
end
