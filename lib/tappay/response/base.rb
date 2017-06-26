module TapPay
  module Response
    class Base
      attr_reader :raw

      def initialize(params, raw = nil)
        @raw = raw

        params.each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def success?
        @status.try(:zero?)
      end

      def [](key)
        try(key)
      end
    end
  end
end
