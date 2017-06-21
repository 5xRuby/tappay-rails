class TapPayCardInput < SimpleForm::Inputs::Base
  def input(_wrapper_options = nil)
    template.tappay_card_input name: "#{object_name}[#{attribute_name}]"
  end
end
