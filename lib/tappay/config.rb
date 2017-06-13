module TapPay
  class Config
    include ActiveSupport::Configurable
    config_accessor :merchantid_id
    config_accessor :vat_number
    config_accessor :partner_key
    config_accessor :app_id
    config_accessor :app_key
    config_accessor :sandbox_app_key
    config_accessor :server_type
  end
end
