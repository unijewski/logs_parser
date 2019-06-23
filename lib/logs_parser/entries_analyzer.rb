# frozen_string_literal: true

module LogsParser
  class EntriesAnalyzer
    def initialize(entries, options = {})
      @entries = entries
      @options = options
    end

    def call
      analyze_entries.each do |hash|
        display_visits_number(hash)
      end
    end

    private

    attr_reader :entries, :options

    def analyze_entries
      analytics_type_class.new(entries).call
    end

    def analytics_type_class
      return ::LogsParser::AnalyticsTypes::MostUniquePageViews if options[:unique]

      ::LogsParser::AnalyticsTypes::MostPageViews
    end

    def display_visits_number(hash)
      puts "#{hash[:page_url]}: #{hash[:occurrences]} #{visits_message}"
    end

    def visits_message
      options[:unique] ? "unique visits" : "visits"
    end
  end
end
