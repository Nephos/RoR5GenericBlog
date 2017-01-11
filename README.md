# RoR5 Generic Blog

## Setup

    bundle install
    export RAILS_ENV=production
    export SECRET_KEY_BASE somethingsecretandrandom
    rake db:create db:migrate
    cp blog.yml.sample blog.yml
    edit blog.yml
    echo "User.create email: 'admin@localhost.localdomain', password: 'password'" | rails c
    rails server -p 3000

