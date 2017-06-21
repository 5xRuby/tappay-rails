module Tappay
  module Rails
    module ApplicationHelper
      def tappay_card_input(
        prime_input_name: nil,
        bincode_input_name: nil,
        lastfour_input_name: nil,
        issuer_input_name: nil,
        funding_input_name: nil,
        type_input_name: nil
      )
        render partial: 'tappay/inputs/basic_tappay_card_number_input',
               locals: {
                 prime_input_name: prime_input_name,
                 bincode_input_name: bincode_input_name,
                 lastfour_input_name: lastfour_input_name,
                 issuer_input_name: issuer_input_name,
                 funding_input_name: funding_input_name,
                 type_input_name: type_input_name
               }
      end
    end
  end
end
