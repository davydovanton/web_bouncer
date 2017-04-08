# WebBouncer

> **Bouncer** - the big fat guy standing in front of the doorway of stripclubs and keeps everyone out if they are not on the "list". ([urbandictionary.com](http://www.urbandictionary.com/define.php?term=bouncer))

In this project, I try to build simple and module auth lib for **any** rack projects.

**Important:** Now it's just a prototype.

## Goals
In Ruby, we have many different auth libs, but each project has one of the shortcomings:

* hard for customization
* works only with rails
* doesn't have documentation or examples of usage

That's why I want to try to build simple and lightweight "auth framework" with the following principles:

### Don't reinvent a wheel
Use only existed solution like OAuth, warden, rodauth or jwt.

### simple and lightweight
If you want to use default logic just use it. If you want to write custom logic you will have an easy way for this.

### Modularity
Ruby has many awesome web frameworks like Rails, hanami, Sinatra, roda, grape, etc. I want to build the solution for all of this. Also if you need to use only oauth or jwt - use only this.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'web_bouncer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install web_bouncer

## Usage
### Base

Add middleware to your `config.ru`:
```ruby
# config.ru

require 'web_bouncer'
require "web_bouncer/middleware"

use WebBouncer::Middleware
run Hanami.app
```

### OAuth

If you want custom existed oauth actions use dry-c logic:
```ruby
class WebBouncer::OauthContainer
  register 'oauth.github_callback' do
    'oauth.github_callback'
  end

  register 'oauth.facebook_callback' do
    'oauth.facebook_callback'
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

