# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerSerializerType
        class ClassificationType < Ledgers::LedgerSerializerType::MappingType
          MAPPING = {
            'asset' => 'Asset',
            'equity' => 'Equity',
            'expense' => 'Expense',
            'liability' => 'Liability',
            'revenue' => 'Revenue'
          }.freeze

          def self.mapping
            @mapping ||= MAPPING
          end
        end
      end
    end
  end
end
