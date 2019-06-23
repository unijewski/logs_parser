# frozen_string_literal: true

RSpec.describe LogsParser::CommandLineHandler do
  subject { described_class.new(path, options) }

  describe "#call" do
    let(:path) { "path_to_log_file" }
    let(:options) { {} }

    let(:log_file_loader) { instance_double("::LogsParser::LogFileLoader", entries: [], call: true) }
    let(:entries_analyzer) { instance_double("::LogsParser::EntriesAnalyzer", call: true) }

    before do
      allow(::LogsParser::LogFileLoader).to receive(:new).and_return(log_file_loader)
      allow(::LogsParser::EntriesAnalyzer).to receive(:new).and_return(entries_analyzer)
    end

    it "invokes LogFileLoader" do
      expect(::LogsParser::LogFileLoader).to receive(:new).with(path)
      expect(log_file_loader).to receive(:call)

      subject.call
    end

    it "invokes EntriesAnalyzer" do
      expect(::LogsParser::EntriesAnalyzer).to receive(:new).with(log_file_loader.entries, options)
      expect(entries_analyzer).to receive(:call)

      subject.call
    end
  end
end
