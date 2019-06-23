# frozen_string_literal: true

require "ostruct"

RSpec.describe LogsParser::EntriesAnalyzer do
  subject { described_class.new(entries, options) }

  describe "#call" do
    let(:entries) { [OpenStruct.new(page_url: "http://example.com", ip_address: "192.168.0.1")] }

    before do
      allow(analytics_class)
        .to receive(:new)
        .with(entries)
        .and_return(analytics_type_instance)
      allow(analytics_type_instance)
        .to receive(:call)
        .and_return([{ page_url: "http://example.com", occurrences: 1 }])
    end

    shared_examples "prints the message" do |message|
      it "prints the message" do
        expect(STDOUT).to receive(:puts).with(message)
        subject.call
      end
    end

    shared_examples "invokes analytics type" do |klass|
      it "invokes analytics type" do
        expect(klass).to receive(:new).with(entries)
        expect(analytics_type_instance).to receive(:call)

        subject.call
      end
    end

    context "when no options provided" do
      let(:options) { {} }
      let(:analytics_class) { ::LogsParser::AnalyticsTypes::MostPageViews }
      let(:analytics_type_instance) { instance_double("::LogsParser::AnalyticsTypes::MostPageViews") }

      it_behaves_like "prints the message", "http://example.com: 1 visits"
      it_behaves_like "invokes analytics type", ::LogsParser::AnalyticsTypes::MostPageViews
    end

    context "when options contain 'unique' key" do
      let(:options) { { unique: true } }
      let(:analytics_class) { ::LogsParser::AnalyticsTypes::MostUniquePageViews }
      let(:analytics_type_instance) { instance_double("::LogsParser::AnalyticsTypes::MostUniquePageViews") }

      it_behaves_like "prints the message", "http://example.com: 1 unique visits"
      it_behaves_like "invokes analytics type", ::LogsParser::AnalyticsTypes::MostUniquePageViews
    end
  end
end
