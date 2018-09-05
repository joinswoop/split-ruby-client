module SplitIoClient
  module Cache
    class Repository
      def set_string(key, str)
        @adapter.set_string(namespace_key(key), str)
      end

      def string(key)
        @adapter.string(namespace_key(key))
      end

      protected

      def namespace_key(key = '')
        "#{SplitIoClient.configuration.redis_namespace}#{key}"
      end

      def impressions_metrics_key(key)
        namespace_key("/#{SplitIoClient.configuration.language}-#{SplitIoClient.configuration.version}/#{SplitIoClient.configuration.machine_ip}/#{key}")
      end
    end
  end
end
