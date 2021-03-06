# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  LedgerSync.resources.each do |resource_class|
    context "when #{resource_class}" do
      context '#ledger_id' do
        it { expect { resource_class.new.ledger_id }.not_to raise_error }
      end
    end
  end

  it 'does not permit unknown attributes' do
    expect { LedgerSync::Ledgers::Stripe::Customer.new(foo: :bar) }.to raise_error(NoMethodError)
  end

  it 'keeps resources separate' do
    customer1 = LedgerSync::Ledgers::Stripe::Customer.new(email: 'test@example.com')
    customer2 = LedgerSync::Ledgers::Stripe::Customer.new
    expect(customer1.email).to eq('test@example.com')
    expect(customer2.email).to be_nil

    customer2.email = 'asdf'
    expect(customer1.email).to eq('test@example.com')
    expect(customer2.email).to eq('asdf')
  end

  context 'customized' do
    let(:custom_resource_class) do
      class_name = "#{test_run_id}Resource2"
      Object.const_get(class_name)
    rescue NameError
      Object.const_set(
        class_name,
        Class.new(LedgerSync::Ledgers::Stripe::Customer) do
          attribute :foo, type: LedgerSync::Type::String
          attribute :type, type: LedgerSync::Type::String
        end
      )
    end

    let(:custom_resource_instance) { custom_resource_class.new }

    it { expect(custom_resource_instance).to respond_to(:name) }
    it { expect(custom_resource_instance.name).to be_nil }

    it { expect(custom_resource_instance).to respond_to(:email) }
    it { expect(custom_resource_instance.email).to be_nil }

    it { expect(custom_resource_instance).to respond_to(:phone_number) }
    it { expect(custom_resource_instance.phone_number).to be_nil }

    it { expect(custom_resource_instance).to respond_to(:foo) }
    it { expect(custom_resource_instance.foo).to be_nil }

    it { expect(custom_resource_instance).to respond_to(:type) }
    it { expect(custom_resource_instance.type).to be_nil }
  end

  describe '#assign_attributes' do
    it do
      resource = LedgerSync::Ledgers::Stripe::Customer.new
      expect(resource.ledger_id).to be_nil
      expect(resource.name).to be_nil
      resource.assign_attributes(ledger_id: 'foo', name: 'bar')
      expect(resource.ledger_id).to eq('foo')
      expect(resource.name).to eq('bar')
    end
  end

  describe '#to_h' do
    it do
      resource = LedgerSync::Ledgers::Stripe::Customer.new
      h = {
        ledger_id: nil,
        external_id: nil,
        name: nil,
        email: nil,
        phone_number: nil
      }
      expect(resource.to_h).to eq(h)
    end
  end

  describe '.operations' do
    it do
      resource_class = LedgerSync::Ledgers::QuickBooksOnline::Customer
      h = {
        create: LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create,
        find: LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Find,
        update: LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Update
      }
      expect(resource_class.operations).to eq(h)
    end
  end
end
