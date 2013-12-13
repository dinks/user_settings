# UserSettings

[![Code Climate](https://codeclimate.com/github/dinks/user_settings.png)](https://codeclimate.com/github/dinks/user_settings)

[![Travis](https://api.travis-ci.org/dinks/user_settings.png)](https://travis-ci.org/dinks/user_settings)

To save user based settings to redis, retrieve them and delete them.

## Installation

Add this line to your application's Gemfile:

    gem 'user_settings'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install user_settings

## Usage

The gem requires a Redis object to be passed for configuration as it stores the key:value in Redis

### Configuration

Create an initializer with configuration

      require 'user_settings'

      UserSettings.configure do |c|

        redis = Redis.new({ host: "127.0.0.1", port: 6379, db: 0 })

        c.redis = redis                             # Set the redis instance
        c.base_path = 'my_custom_base_path/'        # Set a custom base path. 'usettings/' is default
        c.route_drawer = MyCustomClass              # See UserSettings::RouteDrawers::Default
        c.expiration_time = 2.months                # Change the expiration time. 3.months is default
      end


The default routes are

      get_user_settings GET    /usettings/:key(.:format) user_settings#show
      set_user_settings POST   /usettings/:key(.:format) user_settings#create
      set_once_user_settings PUT    /usettings/:key(.:format) user_settings#create_once
      remove_user_settings DELETE /usettings/:key(.:format) user_settings#destroy

The storage is with respect to user and requires a conventional `@current_user` object with an
attribute `id` present. :|

2 JavaScripts are to be included in the layout

For the main javascript file. You might want to add this to the `config.assets.precompile` in `production.rb`

      <%= javascript_include_tag_for_user_settings %>

The user settings are to be initialized with your custom settings in places where you would use it

      <%= init_user_settings %>


### How to use ?

The JavaScript used Promises and jQuery's Deferred which *emulates* Promises. Need to think about this more!

To get a key

      $.userSettings.
        get('test').
        then(function(d) {
          // The response will have
          // - success -> which is either true or false
          // - value  -> value of the key if the success is true
          console.log(d);
        }).
        fail(function(f) {
          // The response will have
          // - status -> 401 if unauthorized
        });

To Set a key with a Value

      $.userSettings.
        set('test', 'two').
        then(function(d) {
          // The response will have
          // - success -> which is either true or false
          // - value  -> "OK" if success is true
          console.log(d);
        }).
        fail(function(f) {
          // The response will have
          // - status -> 401 if unauthorized
        });

To Set a key with a Value *ONCE*

      $.userSettings.
        setOnce('test', 'two').
        then(function(d) {
          // The response will have
          // - success -> which is either true or false. It is true if the set is for the first time
          // - value  -> "OK" if success is true
          console.log(d);
        }).
        fail(function(f) {
          // The response will have
          // - status -> 401 if unauthorized
        });

To Remove a key:value

      $.userSettings.
        remove('test').
        then(function(d) {
          // There will not be any call to then !!
        }).
        fail(function(f) {
          // The response will have
          // - status -> 401 if unauthorized
        });

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
