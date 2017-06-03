module Tappay
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Tappay::Rails
    end
  end
end
