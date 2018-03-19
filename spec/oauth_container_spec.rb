require 'spec_helper'

RSpec.describe WebBouncer::OauthContainer do
  include Dry::Monads::Result::Mixin

  let(:container) { WebBouncer::OauthContainer }
  let(:config) { {} }
  let(:data) { {} }

  describe 'when user rewrite container' do
    class TestContainer < WebBouncer::OauthContainer
      register 'oauth.base_callback' do
        Success('changed')
      end
    end

    class VkCallback
      include Dry::Monads::Result::Mixin
      def initialize(config)
        @config = config
      end

      def call(data)
        Success('vk account')
      end
    end

    class WebBouncer::OauthContainer
      register 'oauth.vk_callback', VkCallback

      register 'oauth.facebook_callback' do
        Success('facebook account')
      end
    end

    it { expect(TestContainer['oauth.base_callback'].call(config, data)).to eq Success('changed') }
    it { expect(container['oauth.facebook_callback'].call(config, data)).to eq Success('facebook account') }
    it { expect(container['oauth.vk_callback'].call(config, data)).to eq Success('vk account') }
  end

  describe 'oauth.failure container' do
    it { expect(container['oauth.failure'].call(config, data)).to eq Success(nil) }
  end

  describe 'oauth.logout container' do
    it { expect(container['oauth.logout'].call(config, data)).to eq Success(nil) }
  end

  describe 'oauth.base_callback container' do
    it { expect(container['oauth.base_callback'].call(config, data)).to eq Success('account object') }
  end
end
