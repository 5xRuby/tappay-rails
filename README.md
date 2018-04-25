# tappay-rails

An API wrapper for [TapPay](https://www.tappaysdk.com).


## Notice

This library is using TapPay API **v2**. See the v2 docs [here|https://onedrive.live.com/download?cid=2E7ABBDC6C509913&resid=2E7ABBDC6C509913%215173&authkey=AH5sDA8pWBPnQ0U]

For **v3** usage, please consider [tappay-ruby|https://github.com/hzchirs/tappay-ruby].


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tappay-rails', github: '5xRuby/tappay-rails'
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

If you are not using jQuery in your project, you may need to require `tappay_with_zepto` instead because [jQuery.payment](https://github.com/stripe/jquery.payment) depends on a jQuery-like lib.

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

### Charge The User

After you get the [prime](https://docs.tappaysdk.com/tutorial/zh/reference.html#prime) (`card.prime`), you can use it whihin 30 seconds to ...

#### Make a one time charge

For example:

```rb
# All the shown arguments are required. For more info, see
# https://docs.tappaysdk.com/tutorial/zh/back.html#pay-by-prime-api
req = TapPay::Request::PayByPrime.new(
  prime: '977d9963e56edcc20b0c0b0351883f38666dc60f08d6fe0f3b6162f736b1ec5b',
  amount: 100,
  details: "An apple and a pen.",
  ptradeid: "TapPay_Test_001",
  cardholder: {
    name: "王小明",
    email: "LittleMing@Wang.com",
    phonenumber: "+886923456789"
  }
)

res = req.request

res.success? # => true
res.rectradeid # => "D20170626vb5MyJ" (this ID will be used for future refunding)
res.orderid # => "TP20170626vb5MyJ"
res.card_info.lastfour # => "4242"
# For more info of the respond object, see
# https://docs.tappaysdk.com/tutorial/zh/back.html#pay-by-prime-api
```

#### Get the card token (or also make a one time charge)

Since the [prime](https://docs.tappaysdk.com/tutorial/zh/reference.html#prime) can only be used once, we can get a card token and save it for future charging, without asking the user for their credit card number again.

To do this, set `remember` to `true` when using the PayByPrime API like this:

```diff
  req = TapPay::Request::PayByPrime.new(
    prime: '977d9963e56edcc20b0c0b0351883f38666dc60f08d6fe0f3b6162f736b1ec5b',
    amount: 100,
    details: "An apple and a pen.",
    ptradeid: "TapPay_Test_001",
    cardholder: {
      name: "王小明",
      email: "LittleMing@Wang.com",
      phonenumber: "+886923456789"
    },
+   remember: true
  )
```

Then, you can get the card token with the response:

```
res = req.request

res.success? # => true
res.card_secret.key # => "2ddb643f375dca31323c79e031ab6b5efbcdfa0294863642afbd9f3be87e032c"
res.card_secret.token # => "977d9963e56edcc20b0c0b0351883f38666dc60f08d6fe0f3b6162f736b1ec5b"
```

... and use them in the future like this:

```rb
# All the shown arguments are required. For more info, see
# https://docs.tappaysdk.com/tutorial/zh/back.html#pay-by-card-token-api
req = TapPay::Request::PayByCardToken.new(
  cardkey: '2ddb643f375dca31323c79e031ab6b5efbcdfa0294863642afbd9f3be87e032c',
  cardtoken: '977d9963e56edcc20b0c0b0351883f38666dc60f08d6fe0f3b6162f736b1ec5b',
  amount: 100,
  details: "An apple and a pen.",
  ptradeid: "TapPay_Test_001"
)

res = req.request
res.success? # => true
# For more info of the respond object, see
# https://docs.tappaysdk.com/tutorial/zh/back.html#pay-by-card-token-api
```

> TODO: Instructions for not charging the user but only get a card token, or also checking the card balance.


## TODO

- Wrap Refund API.
- Wrap Cap Today API.
- Wrap Record API.
- Write tests.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
