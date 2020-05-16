# Interage::Request

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'interage-request', '~> 0.2'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install interage-request
```

## Usage

You can use a Rails generator to install:

```bash
rails g interage:request:install
```

Or you can create the `ApplicationRequest`:

```ruby
# app/requests/application_request.rb
class ApplicationRequest < ::Interage::ApplicationRequest
end
```

And `ApplicationForm`


```ruby
# app/models/application_form.rb
class ApplicationForm < ::Interage::ApplicationForm
end
```

To create a request and form classes you also can use a Rails generator:


```bash
rails g interage:request:create store/order client_name payment_form
```

This will create this classes:

```ruby
# app/requests/orders_request.rb
module Store
  class OrdersRequest < ApplicationRequest
    private

    def klass
      ::Store::Order
    end
  end
end

# app/models/order.rb
class Order < ApplicationForm
  attr_accessor :client_name, :payment_form
end
```

## Contributing

Bug reports and merge requests are welcome on GitLab at
https://github.com/[USERNAME]/interage-request.
