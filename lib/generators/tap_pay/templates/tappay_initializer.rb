TapPay.configure do |config|
  # TapPay Merchantid ID. This is the account name that you use to log in the
  # TapPay Portal.
  config.merchantid_id = 'place_your_merchantid_id_here'

  # VAT Number and Partner Key. This can be found on the "Information" page of
  # TapPay Portal (https://portal.tappaysdk.com/information).
  config.partner_key = 'place_your_partner_key_here'
  config.vat_number = 'place_your_vat_number_here'

  # TapPay App ID and App Key.
  # You can get your ID or create a new app on the "Application" page of
  # TapPay Portal (https://portal.tappaysdk.com/myapps). Note that the App ID
  # on different server types will not be the same.
  config.app_id = 'place_your_app_id_here'
  config.app_key = 'place_your_app_key_here'
  config.sandbox_app_key = 'place_your_sandbox_app_key_here'

  # The server type of TapPay, "sandbox" or "production".
  config.server_type = 'sandbox'
end
