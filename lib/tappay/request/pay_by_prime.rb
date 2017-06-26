require 'tappay/request/pay'
require 'tappay/request/card_holder'
require 'tappay/response/pay_by_prime'

module TapPay
  module Request
    class PayByPrime < Pay
      attr_reader :prime
      attr_reader :cardholder
      attr_reader :remember

      def initialize(*args)
        @remember = false
        super
      end

      def to_hash
        hash = super
        hash[:prime] = @prime
        hash[:cardholder] = @cardholder.try(:to_hash)
        hash[:remember] = @remember
        hash
      end

      def request
        res = send_request('tpc/partner/directpay/paybyprime', to_hash)
        Response::PayByPrime.new(JSON.parse(res.body), res)
      end

      def prime=(prime)
        @prime = prime.to_s
      end

      def cardholder=(cardholder)
        if cardholder.is_a? CardHolder
          @cardholder = cardholder
        elsif cardholder.is_a? Hash
          @cardholder = CardHolder.new(cardholder)
        else
          raise "cardholder must be a hash or an instance of TapPay::Request::CardHolder"
        end
      end

      def remember=(remember)
        if remember == false || remember == 0 || remember == 'false' || remember == 'no' || remember == 'off'
          @remember = false
        else
          @remember = true
        end
      end
    end
  end
end
