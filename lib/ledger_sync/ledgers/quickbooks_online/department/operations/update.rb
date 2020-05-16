# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Department
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:name).filled(:string)
                required(:active).filled(:bool?)
                required(:sub_department).filled(:bool?)
                optional(:fully_qualified_name).maybe(:string)
                optional(:parent).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
