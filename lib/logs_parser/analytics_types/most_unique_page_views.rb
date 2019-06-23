# frozen_string_literal: true

module LogsParser
  module AnalyticsTypes
    class MostUniquePageViews < Base
      private

      def calculate_occurrences(url_entries)
        url_entries.uniq.size
      end
    end
  end
end
