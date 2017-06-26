require 'tappay/request/base'

module TapPay
  module Request
    class CardHolder < Base
      attr_reader :phonenumber
      attr_reader :name
      attr_reader :email
      attr_reader :zip
      attr_reader :addr
      attr_reader :nationalid

      def initialize(*args)
        @zip = ''
        @addr = ''
        @nationalid = ''
        super
      end

      def to_hash
        {
          phonenumber: @phonenumber,
          name: @name,
          email: @email,
          zip: @zip,
          addr: @addr,
          nationalid: @nationalid
        }
      end

      def phonenumber=(phonenumber)
        @phonenumber = phonenumber.to_s
      end

      def name=(name)
        @name = name.to_s
      end

      def email=(email)
        @email = email.to_s
      end

      def zip=(zip)
        @zip = zip.to_s
      end

      def addr=(addr)
        @addr = addr.to_s
      end

      def nationalid=(nationalid)
        @nationalid = nationalid.to_s
      end
    end
  end
end
