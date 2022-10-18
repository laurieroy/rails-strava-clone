# Strava clone

This project is a clone of the workout tracker app, Strava, showing primarily the ability to track runs and shoe mileage. I am building this following a [code along](https://www.railscodealong.com) by Steve Polito(@stevepolitodsgn), 2000.

I had started this using rspec but was finding it difficult to shift from outside in to his approach. My current plan is to follow along here, then finish building out my RSpec-based [version](../../../rails-stridecatcher).

The tech stack is Ruby 2.7.2 on Rails 6.1 with a postgres db, CI with GH actions. Testing is with mini-test, with which I am not as familar, so this will be a nice review.


Application time zone is set to the current_user's time zone, default value is UTC.

Auth: Devise

UI: bootstrap 4 with devise-bootstrapped

Dev dependencies: bullet, strong_migrations, mailcatcher




