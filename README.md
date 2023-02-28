# Strava clone

This project is a clone of the workout tracker app, Strava, showing primarily the ability to track runs and shoe mileage. I am building this following a [code along](https://www.railscodealong.com) by Steve Polito(@stevepolitodsgn), 2020. It is built for the US (imperial/US units), and default pace is per mile.

I had started this using rspec but was finding it difficult to shift from outside in to his approach. My current plan is to follow along here, then finish building out my RSpec-based [version](../../../rails-stridecatcher).

The tech stack is Ruby 2.7.2 on Rails 6.1 with a postgres db, CI with GH actions. Testing is with mini-test, with which I am not as familar, so this will be a nice review.

   
- Application time zone is set to the current_user's time zone, default value is UTC since using PG db.

- For the weekly totals, the default start date is the Monday of the current week.

- Default value for runs etc is miles

Auth: Devise

UI: bootstrap 4 with devise-bootstrapped

Dev dependencies: bullet, strong_migrations, mailcatcher

To run (dev mode): foreman start -f Procfile.dev

### Stuff I learned:
- For the AJAX to be processed, it needs to be `local: false` and not `remote: true`

- id: dom_id(@shoe) helper creates unique id

### TODO:
- Fix totals to remove distance activity.rb when activity is deleted. Case activities.nil

- Review pundit scope (removed from Shoe for it to work), add tests

## To install app:
```
  git clone git@github.com:laurieroy/rails-strava-clone.git
```

### Install dependencies:
```
  bundle
```
### Create database:
```
  rails db:create && rails db:migrate
```

### To run the test suite:
 unit tests: ```rails test```

 system tests: ```rails test:system```


all tests: ```rails test: all```

<!-- Add in others later -->
<!-- Update to 3, rails db:setup -->