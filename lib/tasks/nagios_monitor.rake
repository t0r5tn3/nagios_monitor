
require 'nagios_monitor'

namespace :nagios_monitor do

  require 'yaml'
  require 'nagios_alerter'
  require 'send_nsca'
  require 'rails'
  require 'nagios_monitor'
  require 'nagios_monitor/elastic_search'
  require 'nagios_monitor/es_index'

  # we need to provide the configuration
  begin
    @nagios_config = YAML.load_file("#{Rails.root}/config/nagios.yml")[Rails.env]
  rescue
    begin
      @nagios_config = YAML.load_file(File.expand_path(File.dirname(__FILE__)) + '/../../config/nagios.yml')['development']
    rescue
      raise I18n.t('nagios.configuration.missing')
    end
  end
  raise I18n.t('nagios.configuration.incomplete') if !@nagios_config || !@nagios_config['host'] || !@nagios_config['port'] || !@nagios_config['hostname'] || !@nagios_config['service_name']

  desc 'Send health status as passive nagios monitor'
  task :send_health_status => :environment do
    # wo ist der Status ?

    # STATUS_OK = 0 green
    # STATUS_WARNING = 1 yellow
    # STATUS_CRITICAL = 2 red
    index_status = {'green' => 0, 'yellow' => 1, 'red' => 2 }

    nagios_status = SendNsca::STATUS_OK
    warnings = []

    @es = NagiosMonitor::ElasticSearch.new
    if @es.url    
      status = @es.state
      if status != 'green'
        nagios_status = index_status[status]
        warnings << I18n.t("elasticsearch.health.status.#{status}")
      end
      if @es.indices.any?
        @es.indices.each do |index|
          puts "#{index.model} with index #{index.name}"
          should_have = index.model.classify.constantize.count
          puts "  should have #{should_have} documents"
          puts "  #{index.document_count} found"
          if should_have != index.document_count && nagios_status <= SendNsca::STATUS_CRITICAL
            nagios_status = SendNsca::STATUS_CRITICAL
            warnings << "#{index.name} " + I18n.t("es_index.documents.missing")
          end
            warnings << "#{index.name} " + I18n.t("es_index.documents.missing")

puts nagios_status
puts warnings.join(", ")

        end
      end

    end
puts "status #{nagios_status}"    
puts "warnings #{warnings.join(', ')}"

    setup_connection
    send_status(nagios_status, warnings.join(", "))
    puts "health status send via NSCA"
  end

end


def setup_connection
  Nagios::Connection.instance.host = @nagios_config['host']
  Nagios::Connection.instance.port = @nagios_config['port']
end

def send_status( return_code = SendNsca::STATUS_OK, message = 'OK')

  @alerter = Nagios::Alerter.new(:hostname => @nagios_config['host'],
                                 :service_name => @nagios_config['service_name'],
                                 :return_code => return_code || 0,
                                 :status => message || 'OK')
  @alerter.send_alert()

end
