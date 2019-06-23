# frozen_string_literal: true

RSpec.describe LogsParser::LogFileLoader do
  subject { described_class.new(file_path) }

  describe "#call" do
    context "when the file doesn't exist" do
      let(:file_path) { "wrong_path" }

      it "raises a SystemExit error" do
        expect { subject.call }.to raise_error(SystemExit, "ERROR: file does not exist")
      end
    end

    context "when the file exists" do
      let(:file_path) { "spec/support/fixtures/logs_example.log" }

      it "assigns proper number of entries to 'entries' attribute" do
        subject.call
        expect(subject.entries.size).to eq(2)
      end

      it "creates LogEntry struct instances" do
        subject.call
        expect(subject.entries.map(&:class).uniq).to eq([LogsParser::LogEntry])
      end

      it "splits up URLs and IP addresses properly" do
        subject.call

        expect(subject.entries.first.page_url).to eq("/help_page/1")
        expect(subject.entries.first.ip_address).to eq("126.318.035.038")
        expect(subject.entries.last.page_url).to eq("/contact")
        expect(subject.entries.last.ip_address).to eq("184.123.665.067")
      end
    end
  end
end
