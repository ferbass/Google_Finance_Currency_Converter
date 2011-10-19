require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "GoogleFinanceCurrencyConverter" do
  it "converts 1 british pound to brazilian reais" do
    File.open(File.expand_path(File.dirname(__FILE__) + '/helper/mock.html'), 'r') do |f|
      stub_request(:get, "http://www.google.com/finance/converter?a=1&from=GBP&to=BRL").
          to_return(:body => f)
    end

    converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL')
    converter.value.should == 2.78
  end
end
