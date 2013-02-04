require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "GoogleFinanceCurrencyConverter" do
  it "converts integer to brazilian reais" do
    stub_converted_val(2)

    converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL')
    converter.value.should == 2
  end

  it "converts floats to brazilian reais" do
    stub_converted_val(2.784)

    converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL')
    converter.value.should == 2.784
  end
end

def stub_converted_val(val)
  File.open(File.expand_path(File.dirname(__FILE__) + '/helper/response.html'), 'r') do |f|
    stub_request(:get, "http://www.google.com/finance/converter?a=1&from=GBP&to=BRL").
        to_return(:body => f.read.gsub("<converted_val>", val.to_s))
  end
end