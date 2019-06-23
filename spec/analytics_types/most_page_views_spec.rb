# frozen_string_literal: true

require "ostruct"

RSpec.describe LogsParser::AnalyticsTypes::MostPageViews do
  subject { described_class.new(entries) }

  describe "#call" do
    let(:entries) do
      [
        OpenStruct.new(page_url: "/help_page/1", ip_address: "126.318.035.038"),
        OpenStruct.new(page_url: "/about", ip_address: "184.123.665.067"),
        OpenStruct.new(page_url: "/home", ip_address: "184.123.665.067"),
        OpenStruct.new(page_url: "/help_page/1", ip_address: "929.398.951.889"),
        OpenStruct.new(page_url: "/index", ip_address: "444.701.448.104"),
        OpenStruct.new(page_url: "/help_page/1", ip_address: "722.247.931.582"),
        OpenStruct.new(page_url: "/about", ip_address: "061.945.150.735"),
        OpenStruct.new(page_url: "/help_page/1", ip_address: "646.865.545.408")
      ]
    end
    let(:result) do
      [
        { page_url: "/help_page/1", occurrences: 4 },
        { page_url: "/about", occurrences: 2 },
        { page_url: "/index", occurrences: 1 },
        { page_url: "/home", occurrences: 1 }
      ]
    end

    it "returns results sorted properly" do
      expect(subject.call).to eq(result)
    end
  end
end
