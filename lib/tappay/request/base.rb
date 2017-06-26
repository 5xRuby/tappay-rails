require 'net/https'
require 'json'

module TapPay
  module Request
    class Base
      def initialize(params = nil)
        return unless params.is_a? Hash
        params.each_pair do |key, value|
          send "#{key}=", value
        end
      end

      def [](key)
        try(key)
      end

      def request_host
        TapPay.config.server_type == 'production' ? 'https://prod.tappayapis.com' : 'https://sandbox.tappayapis.com'
      end

      def partner_key
        TapPay.config.partner_key
      end

      def send_request(path, request_hash)
        uri = URI("#{request_host}/#{path}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.read_timeout = 50

        body = JSON.dump(request_hash)

        req = Net::HTTP::Post.new(uri)
        req.add_field "x-api-key", partner_key
        req.add_field "Content-Type", "application/json"
        req.body = body

        http.request(req)
      end
    end
  end
end
