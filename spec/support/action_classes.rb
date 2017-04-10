require 'web_bouncer/authentication'

class Action
  include WebBouncer::Authentication

  attr_reader :session

  def initialize(session = {})
    @session = session
  end
end

class Account
  def initialize(data)
    @attributes = data.to_h
  end

  def id
    @attributes[:id]
  end

  def to_h
    @attributes
  end

  def ==(other)
    to_h == other.to_h
  end
end
