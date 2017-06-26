require 'tappay/response/pay'
require 'tappay/response/card_secret'

module TapPay
  module Response
    class PayByPrime < Pay
      attr_reader :cardsecret

      def initialize(*args)
        super
        @cardsecret = CardSecret.new(@cardsecret) if @cardsecret
      end

      alias card_secret cardsecret
    end
  end
end
