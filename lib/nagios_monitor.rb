
require 'i18n'

Dir.glob( File.expand_path(File.dirname(__FILE__)) + '/nagios_monitor/locales/*.yml' ).each do |y|
  I18n.load_path << File.expand_path(y)
end
I18n.reload!

require "nagios_monitor/version"
require "nagios_monitor/elastic_search"


module NagiosMonitor

  require 'nagios_monitor/railtie' if defined?(Rails)

  require 'nagios_alerter'
  require 'httparty'

end
