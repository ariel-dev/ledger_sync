require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'payments/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:input) do
    {
      adaptor: test_adaptor,
      resource_external_id: :p1,
      resource_type: 'payment',
      method: :update,
      resources_data: payment_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input).operations }
    it { expect(subject.length).to eq(2) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::Test::Customer::Operations::Update) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::Test::Payment::Operations::Update) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
