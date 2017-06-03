Rails.application.routes.draw do
  mount Tappay::Rails::Engine => "/tappay-rails"
end
