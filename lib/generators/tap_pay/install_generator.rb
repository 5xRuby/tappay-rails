require 'rails/generators/base'

module TapPay
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates the TapPay initializer and inserts the frontend SDK."

      def copy_initializer_file
        template "tappay_initializer.rb", ::Rails.root.join('config', 'initializers', 'tappay.rb')

        inject_into_file ::Rails.root.join('app', 'views', 'layouts', 'application.html.erb'), before: "</head>" do
          "  <%= render partial: 'tappay/tappay_sdk' %>\n  "
        end
      end
    end
  end
end
