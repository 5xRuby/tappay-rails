# frozen_string_literal: true
require 'tappay/version'
require 'tappay/config'

module TapPay
  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end

Tappay = TapPay
