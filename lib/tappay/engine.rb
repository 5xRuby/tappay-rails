# frozen_string_literal: true
module TapPay
  class Engine < ::Rails::Engine
    isolate_namespace TapPay

    config.to_prepare do
      ::ApplicationController.helper(TapPay::Engine.helpers)
    end
  end
end
