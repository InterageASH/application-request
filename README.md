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

And `ApplicationParser`


```ruby
# app/models/application_parser.rb
class ApplicationParser < ::Interage::ApplicationParser
end
```

To create a request class you also can use a Rails generator:


```bash
rails g interage:request:create DogsByAge Dog
```

This will create this classes:

```ruby
# app/requests/dogs_by_age_request.rb
class DogsByAgeRequest < ApplicationRequest
  private

  def klass
    Dog
  end

  def base_path
    '/dogs_by_ages'
  end
end

# app/models/dog.rb
class Dog < ApplicationParser
end
```

## Controller example

```ruby
# frozen_string_literal: true

class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  def index
    @dogs = requester.paginate(params[:page])
  end

  def new
    @dog = Dog.new
  end

  def create
    service = requester.create(dog_params)

    if service.success?
      redirect_to dogs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    service = requester.update(@dog.id, dog_params)

    if service.success?
      redirect_to dogs_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    requester.destroy(@dog.id)

    redirect_to dogs_path
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :age)
  end

  def requester
    @requester ||= Volterz::DogRequest.new
  end

  def set_dog
    @dog = requester.find(params[:id])
  end
end
```

## Contributing

Bug reports and merge requests are welcome on GitLab at
https://github.com/[USERNAME]/interage-request.
