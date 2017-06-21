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

To assign the data to any model, you can write a method to permit the params passed in:

```rb
  def credit_card_params
    params.require(:credit_card).permit(data: [:prime, :bincode, :lastfour, :issuer, :funding, :type])
  end
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
