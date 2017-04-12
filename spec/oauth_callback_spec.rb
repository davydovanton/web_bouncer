require 'spec_helper'

RSpec.describe WebBouncer::OauthCallback do
  include Dry::Monads::Either::Mixin

  let(:callback) { WebBouncer::OauthCallback.new(settings) }
  let(:settings) { {} }

  describe '#settings' do
    it { expect(callback.settings).to eq({}) }
  end

  describe '#call' do
    it { expect(callback.call({})).to eq Right(true) }
  end
end
