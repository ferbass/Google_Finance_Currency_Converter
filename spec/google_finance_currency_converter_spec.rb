require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GoogleFinanceCurrencyConverter do
  describe "conversion" do
    it "should work with valid values" do
      stub_converted_response_value(:amount_to_convert => 2, :response_value => 4.784)

      converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL', :amount => 2)
      converter.result.should == 4.784
    end

    it "should return 0 when user wants to convert 0" do
      converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL', :amount => 0)
      converter.result.should == 0
    end

    it "should set amount to 1 when amount is nil" do
      stub_converted_response_value(:amount_to_convert => 1, :response_value => 4.784)

      converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL')
      converter.result.should == 4.784
    end
  end

  describe "raising error" do
    it "should raise 'Same code' if from and to codes are the same" do
      lambda {
        converter = GoogleFinanceCurrencyConverter.new(:from => 'BRL', :to => 'BRL', :amount => 1)
      }.should raise_error("Same code")
    end

    it "should raise 'Result not found' if the conversion doesn't exist" do
      stub_error_response()

      converter = GoogleFinanceCurrencyConverter.new(:from => 'BRL', :to => 'ALL', :amount => 1)
      lambda {
        converter.result
      }.should raise_error("Result not found")
    end
  end
end