# tappay-rails

An API wrapper for [TapPay](https://www.tappaysdk.com).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tappay-rails'
```

And then execute:

```bash
$ bundle
```

Finally, run the install generator:

```bash
$ rails generate tap_pay:install
```

and setup the configurations in `config/initializers/tappay.rb`.

### Installing Front-end Stuff

You'll need to `require tappay` in your JavaScript manifest. Place it after `require jquery` like this in `application.js`:

```diff
  //= require rails-ujs
  //= require turbolinks
  //= require jquery
+ //= require tappay
```

If you are not using jQuery in your project, require `tappay_with_zepto` instead.

```diff
  //= require rails-ujs
  //= require turbolinks
+ //= require tappay_with_zepto
```


## Basic Usage

### In The View

Place `tappay_card_input` in any form:

```erb
<%= form_for @order do |f| %>
  <%= tappay_card_input name: :credit_card %>
  <%= f.submit %>
<% end %>
```

Or, if you are using [Simple Form 2.x](https://github.com/plataformatec/simple_form), add `as: :tappay_card` to any desired input:

```slim
= simple_form_for @credit_card do |f|
  = f.input :data, as: :tappay_card
  = f.submit
```

### Controller Side

You can create an `TapPay::Response::CardInfo` response object using the incoming params:

```rb
card = TapPay::Response::CardInfo.new(params[:credit_card])

card.prime          # => "1a836c4958c1525c7cf3b51bd90b1d3ad4e96dcc287867512f4d267ad4c1e794"
card.lastfour       # => "4242"
card.funding.to_s   # => "Credit Card"
card.funding.to_sym # => :credit_card
card.funding == 0   # => true
card.type.to_s      # => "VISA"
card.type.to_sym    # => :visa
card.type.to_i      # => 1
```

Or to assign the data to any model, you can write a method to permit the params passed in:

```rb
  def credit_card_params
    params.require(:credit_card).permit(data: [:prime, :bincode, :lastfour, :issuer, :funding, :type])
  end
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
