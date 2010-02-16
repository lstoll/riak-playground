# Riak Playground

This is my dumping ground for mucking around with riak

## Getting Started

Ripple requires ActiveSupport (and Model?) from Rails 3. To get everything installed:

    gem install gem install tzinfo builder memcache-client rack rack-test rack-mount erubis mail text-format thor bundler i18n
    gem install rack-mount --version "~> 0.4.0"
    gem install rails --pre
    gem install ripple

You will also need riak installed. Personally I do this using homebrew. I use the
following command to ensure I am not installing from a cached download, and unlinking
spidermonkey which gave me issures in the past. The current recipe in homebrew is
labeled as riak 0.8 but is actually tip which was giving me issues - a proper 0.8
recipe can be found at http://github.com/lstoll/homebrew/blob/5dd77c682ce5859f3f4ded50c1bc7770e8aa1c44/Library/Formula/riak.rb

    brew uninstall riak ; brew unlink spidermonkey ;\
    rm /Users/lstoll/Library/Caches/Homebrew/riak-0.8.zip ;  brew install riak ;\
    brew link spidermonkey

you can then run 'riak start' to get the server up and running

