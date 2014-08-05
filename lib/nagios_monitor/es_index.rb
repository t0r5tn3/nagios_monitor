require 'httparty'
require 'json'

# elasticsearch index
module NagiosMonitor
  class EsIndex

    attr_accessor :name, :model, :url

    def initialize(name, model, url)
      @name = name
      @model = model
      @url = url
    end

    def document_count
      stats['docs']['count'] || 0
    end

    def stats
      response = HTTParty.get("#{url}/#{name}/_stats")
      body = JSON.parse(response.body)
      # real index name in body['indices']
      actual = body['indices'].first.first
      stats = body['indices']["#{actual}"]['primaries']
    end

    def state
      response = HTTParty.get("#{url}/_cluster/health/#{name}")
      body = JSON.parse(response.body)
      stats = body['status']
    end

  end
end
