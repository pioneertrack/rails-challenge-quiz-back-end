# Backend Test

<div style='text-align: center; background: #222; padding: 30px 0;'>
	<img src='https://media.giphy.com/media/PuWNMebKGIKNG/giphy.gif' width='40%'>
</div>

### Local Installation

To simplify installation and configuration the application and its dependencies are handled with Docker Compose. Docker Compose installation instructions for Mac, Linux and Windows are [here](https://docs.docker.com/compose/install/).

Docker & DockerCompose Versions

* Docker ~18
* DockerCompose ~1.2

With the above software installed you can spin it up simply with:

```bash
$ cd /path/to/rails-challenge
$ docker-compose build
$ docker-compose up
```

To access the command line of the docker container and migrate the database open another terminal tab or window and run:

```bash
$ docker-compose exec rails bash
$ rake db:setup
```

From here you can access the Rails console as well as run tests with:

```bash
$ bundle exec rspec
```
<br>

### Application Software and Database Versions

Because we are leveraging docker you do not have to install any local dependencies. This list is for your edification while solving the problems laid out below.

* Ruby >= 2.5.1
* Rails >= 5.2
* Postgres ~10.3

This server was initialized as an api only backend. It does not render views, only json.

<br>

### High Level Instructions

A series of methods that work together have been emptied out. Each of these have a suite of unit tests in the spec directory. **Do NOT edit or add to these tests.** Each of the empty methods has explicit **TODO comments**. Follow these as best you can. Please review this entire doc with all of its instructions and all of the **TODO comments** before beginning. If you are confused by any of the directions please reach out to us at this <a href='mailto:adam@mediazilla.com'>email</a>. It would be preferable if this is done in one email so that we are efficient in responding to any misunderstandings.

* Flesh out the empty TODO methods
* Create any methods that you need to support the existing, required methods
* Do not change the names of existing methods
* Do not add any new migrations
* Do not change any of the existing database table or column names or types
* Do not make changes to the routes file
* Do not edit the tests
* Do not edit the `config/*` files
* Add columns to existing migrations if needed
* All responses that handle errors should have a message in the response body
* None of the tests should return 50* status codes
* All necessary gems are already listed in the Gemfile

<br>

### Components To Resolve

#### Authentication

There are 4 files that need to be changed in order to resolve the Authentication module:

* `lib/util/json_web_token.rb`
* `app/models/user.rb`
* `app/controllers/application_controller.rb`
* `app/controllers/login_controller.rb`

#### Users

There are 2 files that need to be changed in order to resolve the User module:

* `app/models/user.rb` (model validations)
* `app/controllers/users_controller.rb`

#### Calendars

There are 2 files that need to be changed in order to resolve the Calendar module:

* `app/models/calendar.rb`
* `app/controllers/calendars_controller.rb`

#### Events

There are 2 files that need to be changed in order to resolve the Event module:

* `app/models/event.rb`
* `app/controllers/events_controller.rb`

#### Debug Test

There are a hand full of bugs floating around too.

<br>

### Lastly

Before you submit your quiz back to us, please be sure to answer all of the questions in the [essay](./essay.md) portion as well. We look at those to get more insight into how you think and solve problems.
<br>
<br>
Clean and clear is what we are looking for. Take your time. You got this!

<div style='text-align: center; background: #222; padding: 30px 0;'>
	<img src='https://media.giphy.com/media/vMnuZGHJfFSTe/giphy.gif' width='40%'>
</div>
