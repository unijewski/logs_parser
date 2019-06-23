# frozen_string_literal: true

module LogsParser
  LogEntry = Struct.new(:page_url, :ip_address)

  class LogFileLoader
    attr_reader :entries

    def initialize(file_path)
      @file_path = file_path
      @entries = []
    end

    def call
      load_entries
    rescue Errno::ENOENT
      abort "ERROR: file does not exist"
    end

    private

    attr_reader :file_path

    def load_entries
      File.open(file_path, "r") do |file|
        until file.eof?
          line = file.readline
          parse_single_entry(line)
        end
      end
    end

    def parse_single_entry(line)
      page_url, ip_address = line.split
      entries << LogEntry.new(page_url, ip_address)
    end
  end
end
