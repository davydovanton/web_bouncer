require 'spec_helper'
require 'web_bouncer/authentication'
require 'support/action_classes'

RSpec.describe WebBouncer::Authentication do
  let(:action) { Action.new(account: account) }
  let(:account){ Account.new(id: 1) }

  describe '#current_account' do
    context 'when account does not exist' do
      let(:action) { Action.new(account: nil) }
      let(:account){ Account.new(nil) }

      it { expect(action.current_account).to eq account }
    end

    context 'when account exist' do
      it { expect(action.current_account).to eq account }
    end
  end

  describe '#authenticated?' do
    context 'when account does not exist' do
      let(:action) { Action.new(account: nil) }

      it { expect(action.authenticated?).to eq false }
    end

    context 'when account exist' do
      it { expect(action.authenticated?).to eq true }
    end
  end
end
