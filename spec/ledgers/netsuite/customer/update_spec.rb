# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::NetSuite::Customer::Operations::Update do
  include InputHelpers
  include NetSuiteHelpers

  let(:resource) { LedgerSync::Customer.new(customer_resource(ledger_id: 1137)) }
  let(:client) { netsuite_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_customer_find
                    stub_customer_update
                  ]
end