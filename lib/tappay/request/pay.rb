require 'tappay/request/base'

module TapPay
  module Request
    class Pay < Base
      attr_reader :vatnumber
      attr_reader :partnerkey
      attr_reader :merchantid

      attr_reader :amount
      attr_reader :currency
      attr_reader :ptradeid
      attr_reader :orderid
      attr_reader :details

      attr_reader :instalment
      attr_reader :authtocapperiodinday

      def initialize(*args)
        @instalment = 0
        @merchantid = TapPay.config.merchant_id
        @vatnumber = TapPay.config.vat_number
        @partnerkey = TapPay.config.partner_key
        @currency = TapPay.config.default_currency
        super
      end

      def to_hash
        {
          vatnumber: @vatnumber,
          partnerkey: @partnerkey,
          merchantid: @merchantid,
          amount: @amount,
          currency: @currency,
          ptradeid: @ptradeid,
          orderid: @orderid,
          details: @details,
          instalment: @instalment,
          authtocapperiodinday: @authtocapperiodinday
        }
      end

      def vatnumber=(vatnumber)
        @vatnumber = vatnumber.to_s
      end

      def partnerkey=(partnerkey)
        @partnerkey = partnerkey.to_s
      end

      def merchantid=(merchantid)
        @merchantid = merchantid.to_s
      end

      def amount=(amount)
        @amount = amount.to_i
      end

      def currency=(currency)
        @currency = currency.to_s
      end

      def ptradeid=(ptradeid)
        @ptradeid = ptradeid.to_s
      end

      def orderid=(orderid)
        @orderid = orderid.to_s
      end

      def details=(details)
        @details = details.to_s
      end

      def instalment=(instalment)
        @instalment = instalment.to_i
      end

      def authtocapperiodinday=(authtocapperiodinday)
        @authtocapperiodinday = authtocapperiodinday.to_i
      end
    end
  end
end
