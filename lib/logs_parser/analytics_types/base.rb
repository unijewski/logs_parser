# frozen_string_literal: true

module LogsParser
  module AnalyticsTypes
    class Base
      def initialize(entries_to_analyze)
        @entries_to_analyze = entries_to_analyze
      end

      def call
        sort_page_views_descending
      end

      private

      attr_reader :entries_to_analyze

      def sort_page_views_descending
        group_page_views
          .sort_by { |hash| hash[:occurrences] }
          .reverse!
      end

      def group_page_views
        entries_to_analyze
          .group_by(&:page_url)
          .map do |page_url, url_entries|
            { page_url: page_url, occurrences: calculate_occurrences(url_entries) }
          end
      end

      def calculate_occurrences(_url_entries)
        raise NotImplementedError, :calculate_occurrences
      end
    end
  end
end
