# Overview

Dwight Scott's Wantable Code Challenge submission

## technologies

Leveraged existing technolgies listed below. However a few gems were
installed to compliment what was existing.

- pry (debugging)
- rspec (testing)
- factory_bot_rails (testing and creating data easily)
- will_paginate (popular pagination gem)

## getting started

- run `bundle` to install any missing gems
- run `bundle exec rails s` to start the server
- run `bundle exec rspec` to run the tests

## quick notes

I've added a `users_controller` to demonstrate how to reuse partials and
to filter associated data even further. I've also crated a few helper
method based on the `STATES` constant in it's respective model.

## TODO

- Add more specs to controllers
- Improve navigation (mainly for users view)
- Make "Cancel Order" button an ajax call and render partials on `200`


# REQUIREMENTS BELOW


# Wantable Code Challenge App (Simple E-Commerce)

Welcome to the challenge portion of your Wantable Rails interview! Here we've provided a sample application and database with data already created and we're asking you to make some backend order fulfillment and reporting pages for it! The goal is to spend 3-5 hours on this so don't go overboard with styling or making it look perfect; we're looking to see how you implement the solutions. There are a ton of different ways to meet these requirements and we want to see what you would do and what you're most comfortable building in. Choose your own adventure! Feel free to add/remove routes/controllers/gems/frontend frameworks if you feel like it better "completes" the app or you are more comfortable with.

### Technologies
- Ruby 2.6.6
- Rails 5.2.4
- [Bootstrap 3](https://getbootstrap.com/docs/3.4/)
- Haml

### Requirements
Build out the following features, your project into Github to share with Wantable IT.

#### Views
  - Order List & Order Search functionality
    - Include at least the order number, state and user email address, any additional information that you think would be helpful to view in the list and search by.
  - Order Detail
    - Display Address / User / OrderItems / Payments

#### Reports:
  - Coupon Users
    - Provide a dropdown to select coupons.
    - Display user email, number of and revenue in orders after the coupon order for that customer
  - Sales By Product
    - Provide a date range
    - Display a table of products name, sold count and revenue during that date range

### Bonus points
  - Cancel order button
  - Pagination
  - Unit testing

### Supporting Information
  - [erd diagram](https://github.com/wantable/rails_code_challenge/blob/master/erd.pdf) (generated with rails-erd)
  - All stateful models have associated `_at` timestamps
  - Orders have 3 states: building, arrived and canceled
    - When the order is canceled all product order items move returned & payments move to refunded
  - Order Items have 2 states: sold and returned
    - Only product order items have states
  - Payments have 2 states: completed and refunded
    - refunded payments do not count towards sales totals
