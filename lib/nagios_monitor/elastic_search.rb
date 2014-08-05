require 'httparty'
require 'json'

module NagiosMonitor
  class ElasticSearch

    def initialize( args = {} )
      @es_mode = args[:mode] || mode
      @es_url = args[:url] || url
      @es_indices = args[:indices] || indices

    end

    def self.url
      autourl
    end

    def self.mode
      automode
    end

    def self.indices
      autoindices
    end

    def mode
      @es_mode || self.class.automode || 'none'
    end

    def url
      @es_url || self.class.autourl
    end

    def indices
      @es_indices || self.class.autoindices
    end

    def stats
      response = HTTParty.get("#{url}/_cluster/stats")
      body = JSON.parse(response.body)
      stats = body['status']
      # muss noch geändert werden
    end

    def state
      response = HTTParty.get("#{url}/_cluster/health")
      body = JSON.parse(response.body)
      stats = body['status']
    end

    private

    # try to investigate some default stuff
    def self.automode
      return 'tire' if Gem::Specification::find_all_by_name('tire').any?
      return 'searchkick' if Gem::Specification::find_all_by_name('searchkick').any?
      return 'elasticsearch' if Gem::Specification::find_all_by_name('elasticsearch').any?
    end

    def self.autourl
      es_mode = mode
      return if es_mode == 'none'
      case es_mode
      when 'tire'
        Tire::Configuration.url() if Gem::Specification::find_all_by_name('tire').any?
      when 'searchkick'
        ENV["ELASTICSEARCH_URL"] || 'http://localhost:9200'
      when 'elasticsearch'
        'no idea yet'
      end
    end

    def self.autoindices
      es_mode = mode
      return if es_mode == 'none'

      indices = []
      found_indices = {}

      begin
        Rails.application.eager_load!

        ActiveRecord::Base.send(:subclasses).each do |m|
          case es_mode
          when 'tire'
            found_indices[m.name] = m.try(:tire).try(:index_name) unless m.try(:tire).try(:index_name).nil?
          when 'searchkick'
            found_indices[m.name] = m.try(:searchkick_index).try(:name) unless m.try(:searchkick_index).try(:name).nil?
          when 'elasticsearch'
            # todo
          end
        end
      rescue
        # ignore this
      end
      found_indices.each do |model,name|
        indices << EsIndex.new(name, model, url)
      end

      indices
    end

  end
end
