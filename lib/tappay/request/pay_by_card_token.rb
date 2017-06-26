require 'tappay/request/pay'
require 'tappay/response/pay_by_card_token'

module TapPay
  module Request
    class PayByCardToken < Pay
      attr_reader :cardkey
      attr_reader :cardtoken

      def initialize(*args)
        super
      end

      def to_hash
        hash = super
        hash[:cardkey] = @cardkey
        hash[:cardtoken] = @cardtoken
        hash
      end

      def request
        res = send_request('tpc/partner/directpay/paybytoken', to_hash)
        Response::PayByCardToken.new(JSON.parse(res.body), res)
      end

      def cardkey=(cardkey)
        @cardkey = cardkey.to_s
      end

      def cardtoken=(cardtoken)
        @cardtoken = cardtoken.to_s
      end
    end
  end
end
