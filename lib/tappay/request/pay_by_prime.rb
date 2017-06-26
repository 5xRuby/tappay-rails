require 'tappay/request/base'
require 'tappay/request/card_holder'
require 'tappay/response/pay_by_prime'

module TapPay
  module Request
    class PayByPrime < Base
      attr_reader :prime
      attr_reader :vatnumber
      attr_reader :partnerkey
      attr_reader :merchantid
      attr_reader :amount
      attr_reader :currency
      attr_reader :ptradeid
      attr_reader :orderid
      attr_reader :details
      attr_reader :cardholder
      attr_reader :instalment
      attr_reader :authtocapperiodinday
      attr_reader :remember

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
          prime: @prime,
          vatnumber: @vatnumber,
          partnerkey: @partnerkey,
          merchantid: @merchantid,
          amount: @amount,
          currency: @currency,
          ptradeid: @ptradeid,
          orderid: @orderid,
          details: @details,
          cardholder: @cardholder.try(:to_hash),
          instalment: @instalment,
          authtocapperiodinday: @authtocapperiodinday,
          remember: @remember
        }
      end

      def request
        res = send_request('tpc/partner/directpay/paybyprime', to_hash)
        Response::PayByPrime.new(JSON.parse(res.body), res)
      end

      def prime=(prime)
        @prime = prime.to_s
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

      def cardholder=(cardholder)
        if cardholder.is_a? CardHolder
          @cardholder = cardholder
        elsif cardholder.is_a? Hash
          @cardholder = CardHolder.new(cardholder)
        else
          raise "cardholder must be a hash or an instance of TapPay::Request::CardHolder"
        end
      end

      def instalment=(instalment)
        @instalment = instalment.to_i
      end

      def authtocapperiodinday=(authtocapperiodinday)
        @authtocapperiodinday = authtocapperiodinday.to_i
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
