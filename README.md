# RoR5 Generic Blog

## Setup

    bundle install

    export RAILS_ENV=production
    export SECRET_KEY_BASE=your_devise_key

    rake db:create db:migrate

    cp blog.yml.sample blog.yml
    edit blog.yml
    echo "User.create email: 'admin@localhost.localdomain', password: 'password'" | rails c

    rails server -p 3000

## Routes

    /read(:format)      # list the 10 last articles with
    /read
    /read.html
    /read.json
    /read.rss
    /read/:id.(:format) # fetch the complete article (replace :id with an integer)
    /read/:id
    /read/:id.html
    /read/:id.json
    /read/:id.tex
    /read/:id.pdf
    /read/:id.md
    /last               # fetch the last published article
