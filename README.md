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

And `ApplicationBuilder`


```ruby
# app/builders/application_builder.rb
class ApplicationBuilder < ::Interage::ApplicationBuilder
end
```

To create a request and builder classes you also can use a Rails generator:


```bash
rails g interage:request:create store/order client_name payment_form
```

This will create this classes:

```ruby
# app/requests/store/base_request.rb
module Store
  class BaseRequest < ::ApplicationRequest
    private

    def api_base_url
      "#{ENV.fetch('STORE_BASE_URL')}/v1/"
    end

    def headers
      { 'Authorization-Token': ENV.fetch('STORE_AUTHORIZATION_TOKEN') }
    end
  end
end

# app/requests/store/orders_request.rb
module Store
  class OrdersRequest < ::Store::BaseRequest
    private

    def key_name
      :order
    end

    def klass
      ::Store::Order
    end
  end
end

# app/builders/store/order.rb
module Store
  class Order < ApplicationBuilder
    attr_accessor :client_name,
                  :payment_form

    def requester
      @requester ||= ::Store::OrdersRequest.new
    end

    private

    def changeable_attributes
      { client_name: client_name,
        payment_form: payment_form }
    end
  end
end
```

## Controller usage

```ruby
# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_new_order, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.paginate(params[:page])
  end

  def new
  end

  def create
    if @order.create(order_params)
      redirect_to orders_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to orders_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @order.destroy

    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:name, :age)
  end

  def set_new_order
    @order = Order.new
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
```

## Contributing

Bug reports and merge requests are welcome on GitLab at
https://github.com/[USERNAME]/interage-request.
