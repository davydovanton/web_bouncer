require 'spec_helper'
require 'web_bouncer/authentication'
require 'support/action_classes'

RSpec.describe WebBouncer::Authentication do
  let(:action) { Action.new(account: account) }
  let(:account){ Account.new(nil) }

  describe '#current_account' do
    it { expect(action.current_account).to eq account }
  end
end
