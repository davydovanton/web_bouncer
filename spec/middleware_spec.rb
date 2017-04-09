require 'spec_helper'

RSpec.describe WebBouncer::Middleware do
  class WebBouncer::OauthContainer
    register 'oauth.facebook_callback' do
      Right('facebook account')
    end
  end

  describe 'config' do
    it { expect(app.opts).to eq({}) }
  end

  describe 'auth/failure' do
    before { get '/auth/failure' }

    context 'when all is ok' do
      it { expect(last_response).to be_ok }
      it { expect(last_response.body).to eq 'Successed ' }
    end
  end

  describe 'auth/logout' do
    before { get '/auth/logout', "rack.session" => { account: :value } }

    it { expect(last_response).to be_redirect }
    it { expect(last_request.env["rack.session"][:account]).to eq nil }

    it 'redirects to root path' do
      follow_redirect!
      expect(last_request.url).to eq  "http://example.org/"
    end
  end

  describe 'auth/:provider/callback' do
    context 'when provider exist' do
      before { get '/auth/facebook/callback', "rack.session" => { account: nil } }

      it { expect(last_response).to be_redirect }
      it { expect(last_request.env["rack.session"][:account]).to eq 'facebook account' }

      it 'redirects to root path' do
        follow_redirect!
        expect(last_request.url).to eq  "http://example.org/"
      end
    end

    context 'when provider exist' do
      before { get '/auth/notexist/callback', "rack.session" => { account: nil } }

      it { expect(last_response).to be_redirect }
      it { expect(last_request.env["rack.session"][:account]).to eq 'account object' }

      it 'redirects to root path' do
        follow_redirect!
        expect(last_request.url).to eq  "http://example.org/"
      end
    end
  end
end
