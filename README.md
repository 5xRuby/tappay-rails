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

Place `tappay_card_input` in any form:

```erb
<%= form_for @order do |f| %>
  <%= tappay_card_input %>
  <%= f.submit %>
<% end %>
```

<!-- TODO: Make Simple Form compatible -->


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
