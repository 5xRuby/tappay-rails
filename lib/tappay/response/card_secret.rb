require 'tappay/response/base'

module TapPay
  module Response
    class CardSecret < Base
      attr_reader :cardtoken
      attr_reader :cardkey

      alias card_token cardtoken
      alias token cardtoken
      alias card_key cardkey
      alias key cardkey
    end
  end
end
