# frozen_string_literal: true

module LogsParser
  class CommandLineHandler
    def initialize(path, options)
      @path = path
      @options = options
    end

    def call
      load_file
      analyze_entries(file_loader.entries)
    end

    private

    attr_reader :path, :options

    def load_file
      file_loader.call
    end

    def file_loader
      @file_loader ||= ::LogsParser::LogFileLoader.new(path)
    end

    def analyze_entries(entries)
      ::LogsParser::EntriesAnalyzer.new(entries, options).call
    end
  end
end
