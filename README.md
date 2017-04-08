# WebBouncer

> **A bouncer** is the first face you see when entering a bar, pub, or night club, and how they treat you often sets the mood for the night. they make sure everyone who enters the establishment is of legal drinking age, not overly intoxicated, dressed according the the bars dresscode, not carying any weapons or drugs ([urbandictionary.com](http://www.urbandictionary.com/define.php?term=bouncer)).

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

If you want to define custom oauth actions, you need to use dry-containers. For this, you redefine container with an object which has `#call` methods (proc, class, etc.). After, you need to return right (success) or left (failure) monad. For example:

```ruby
# lib/auth/oauth/github_callback.rb
class GithubCallback
  def call
    if condition
      Right(account)
    else
      Left(error_message)
    end
  end
end

# lib/auth/oauth_container.rb
class WebBouncer::OauthContainer
  register 'oauth.github_callback', GithubCallback.new

  register 'oauth.facebook_callback' do
    Left(:not_implement)
  end
end
```

Now, when you call `/auth/github` you'll create github account and set it to `env` variable. If you call `/auth/facebook` you'll get a error and that's all. If you call different provider you'll call base oauth action.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

