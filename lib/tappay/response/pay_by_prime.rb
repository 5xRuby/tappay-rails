require 'tappay/response/base'
require 'tappay/response/card_secret'
require 'tappay/response/card_info'

module TapPay
  module Response
    class PayByPrime < Base
      attr_reader :status
      attr_reader :msg
      attr_reader :rectradeid
      attr_reader :orderid
      attr_reader :authcode
      attr_reader :cardsecret
      attr_reader :cardinfo
      attr_reader :acquirer
      attr_reader :millis
      attr_reader :banktransactiontime

      def initialize(*args)
        super
        @cardsecret = CardSecret.new(@cardsecret) if @cardsecret
        @cardinfo = CardInfo.new(@cardinfo) if @cardinfo
      end

      alias card_secret cardsecret
      alias card_info cardinfo
    end
  end
end
