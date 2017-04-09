require 'spec_helper'

RSpec.describe WebBouncer do
  it { expect(WebBouncer::Matcher).to eq Dry::Matcher::EitherMatcher }
end
