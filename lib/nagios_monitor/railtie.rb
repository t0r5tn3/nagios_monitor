require 'nagios_monitor'
require 'nagios_monitor/elastic_search'
require 'nagios_monitor/es_index'

module NagiosMonitor
  class Railtie < Rails::Railtie
    railtie_name :nagios_monitor

    rake_tasks do
      load "tasks/nagios_monitor.rake"
    end
  end
end
