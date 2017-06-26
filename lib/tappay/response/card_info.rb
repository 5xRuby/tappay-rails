require 'tappay/response/base'

module TapPay
  module Response
    class CardInfo < Base
      class EnumNumber
        def initialize(value)
          @value = value.to_i
        end

        def ==(other)
          @value == other
        end

        def method_missing(name, *args, &blk)
          @value.respond_to?(name) ? @value.try(name, *args, &blk) : super
        end

        def respond_to_missing?(name)
          @value.respond_to?(name)
        end
      end

      class Funding < EnumNumber
        def to_s
          case @value
          when 0
            'Credit Card'
          when 1
            'Debit Card'
          when 2
            'Prepaid Card'
          else
            'Unknown'
          end
        end

        def to_sym
          case @value
          when 0
            :credit_card
          when 1
            :debit_card
          when 2
            :prepaid_card
          else
            :unknown
          end
        end
      end

      class Type < EnumNumber
        def to_s
          case @value
          when 1
            'VISA'
          when 2
            'MasterCard'
          when 3
            'JCB'
          else
            'Unknown'
          end
        end

        def to_sym
          case @value
          when 1
            :visa
          when 2
            :master_card
          when 3
            :jcb
          else
            :unknown
          end
        end
      end

      attr_reader :bincode
      attr_reader :lastfour
      attr_reader :issuer
      attr_reader :funding
      attr_reader :type
      attr_reader :prime

      def initialize(*args)
        super
        @funding = Funding.new(@funding) if @funding
        @type = Type.new(@type) if @type
      end
    end
  end
end
