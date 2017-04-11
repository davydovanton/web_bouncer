require 'spec_helper'

RSpec.describe WebBouncer::OauthContainer do
  include Dry::Monads::Either::Mixin

  let(:container) { WebBouncer::OauthContainer }
  let(:config) { {} }
  let(:data) { {} }

  describe 'when user rewrite container' do
    class TestContainer < WebBouncer::OauthContainer
      register 'oauth.base_callback' do
        Right('changed')
      end
    end

    class VkCallback
      include Dry::Monads::Either::Mixin
      def initialize(config)
        @config = config
      end

      def call(data)
        Right('vk account')
      end
    end

    class WebBouncer::OauthContainer
      register 'oauth.vk_callback', VkCallback

      register 'oauth.facebook_callback' do
        Right('facebook account')
      end
    end

    it { expect(TestContainer['oauth.base_callback'].call(config, data)).to eq Right('changed') }
    it { expect(container['oauth.facebook_callback'].call(config, data)).to eq Right('facebook account') }
    it { expect(container['oauth.vk_callback'].call(config, data)).to eq Right('vk account') }
  end

  describe 'oauth.failure container' do
    it { expect(container['oauth.failure'].call(config, data)).to eq Right(nil) }
  end

  describe 'oauth.logout container' do
    it { expect(container['oauth.logout'].call(config, data)).to eq Right(nil) }
  end

  describe 'oauth.base_callback container' do
    it { expect(container['oauth.base_callback'].call(config, data)).to eq Right('account object') }
  end
end
