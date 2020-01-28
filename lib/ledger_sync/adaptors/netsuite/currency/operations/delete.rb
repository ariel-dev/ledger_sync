# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Currency
        module Operations
          class Delete < NetSuite::Operation::Delete
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:exchange_rate).maybe(:float)
                required(:name).maybe(:string)
                required(:symbol).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end