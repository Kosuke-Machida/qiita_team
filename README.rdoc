# machio team
## Overview
This is Rails application inspired by [Qiita team](https://teams.qiita.com/).

You can do
- Create your own account
- See timeline
- Search articles
- Post public/private article
- Add tags to your article
- Create and join public/private group

and articles have *Realtime Markdown* and "Syntax Highlight"

## How to Run
 ```
$ bundle install
$ cp .env.sample .env
// Edit .env to set your local environment variable
$ bundle exec rake db:create
$ bundle exec rake db:migration
$ bundle exec rake db:seed_fu
$ bundle exec rails s -p 3000
 ```
