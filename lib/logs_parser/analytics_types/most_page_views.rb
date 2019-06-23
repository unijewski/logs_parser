# frozen_string_literal: true

module LogsParser
  module AnalyticsTypes
    class MostPageViews < Base
      private

      def calculate_occurrences(url_entries)
        url_entries.size
      end
    end
  end
end
