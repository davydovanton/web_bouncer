require 'spec_helper'

RSpec.describe WebBouncer::OauthContainer do
  include Dry::Monads::Either::Mixin

  let(:container) { WebBouncer::OauthContainer }

  describe 'when user rewrite container' do
    class TestContainer < WebBouncer::OauthContainer
      register 'oauth.base_callback' do
        Right('changed')
      end
    end

    class WebBouncer::OauthContainer
      register 'oauth.facebook_callback' do
        Right('facebook account')
      end
    end

    it { expect(TestContainer['oauth.base_callback'].call).to eq Right('changed') }
    it { expect(container['oauth.facebook_callback'].call).to eq Right('facebook account') }
  end

  describe 'oauth.failure container' do
    it { expect(container['oauth.failure'].call).to eq Right(nil) }
  end

  describe 'oauth.logout container' do
    it { expect(container['oauth.logout'].call).to eq Right(nil) }
  end

  describe 'oauth.base_callback container' do
    it { expect(container['oauth.base_callback'].call).to eq Right('account object') }
  end
end
