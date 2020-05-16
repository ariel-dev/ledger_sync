# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'DetailType' do
            'AccountBasedExpenseLineDetail'
          end

          attribute ledger_attribute: 'AccountBasedExpenseLineDetail.AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute ledger_attribute: 'AccountBasedExpenseLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
