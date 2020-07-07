# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Currency
        class Deserializer < QuickBooksOnline::Deserializer
          attribute :symbol,
                    hash_attribute: :value

          attribute :name
        end
      end
    end
  end
end
