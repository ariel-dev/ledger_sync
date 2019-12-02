module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Payment
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                optional(:amount).maybe(:integer)
                optional(:currency).maybe(:string)
                optional(:customer).hash(Types::Reference)
                optional(:deposit_account).hash(Types::Reference)
                optional(:exchange_rate).maybe(:float)
                required(:ledger_id).filled(:string)
                optional(:line_items).array(Types::Reference)
                optional(:memo).maybe(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).maybe(:date?)
              end
            end
          end
        end
      end
    end
  end
end
