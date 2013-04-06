stardust
========

shits dope yo

develoment setup
----------------

bundle install

    $ bundle install

confgiure your application.yml

    $ cp config/application.yml.sample config/application.yml

create your own secret token

    $ rake secret
    # replace the SECRET_TOKEN in config/application.yml

configure your database.yml

    $ cp config/database.yml.sample config/database.yml

run database migrations

    $ rake db:migrate

seed database with data (see https://github.com/mbleigh/seed-fu)

    $ rake db:seed_fu

boot the development server

    $ rails server

memcached keys
--------------
city:[id]
state:[id]

states
cities
cities:[state_id]