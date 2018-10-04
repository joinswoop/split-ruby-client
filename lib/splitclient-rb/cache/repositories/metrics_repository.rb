module SplitIoClient
  module Cache
    module Repositories
      # Repository which forwards impressions interface to the selected adapter
      class MetricsRepository < Repository
        extend Forwardable
        def_delegators :@adapter, :add_count, :add_latency, :add_gauge, :counts, :latencies, :gauges,
                       :clear_counts, :clear_latencies, :clear_gauges, :clear

        def initialize(adapter)
          @adapter = case adapter.class.to_s
          when 'SplitIoClient::Cache::Adapters::MemoryAdapter'
            Repositories::Metrics::MemoryRepository.new(adapter)
          when 'SplitIoClient::Cache::Adapters::RedisAdapter'
            Repositories::Metrics::RedisRepository.new(adapter)
          end
        end
      end
    end
  end
end
