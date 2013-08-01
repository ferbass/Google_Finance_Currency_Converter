require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GoogleFinanceCurrencyConverter do
  describe "conversion" do
    it "should work with currency that returns an integer" do
      stub_converted_val_response(2)

      converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL')
      converter.rate.should == 2
    end
    
    it "should work with currency that returns a float" do
      stub_converted_val_response(2.784)

      converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL')
      converter.rate.should == 2.784
    end
  end
  
  describe "raising error" do
    it "should raise 'Same code' if from and to codes are the same" do
      lambda {
        converter = GoogleFinanceCurrencyConverter.new(:from => 'BRL', :to => 'BRL')
      }.should raise_error("Same code")
    end
    
    it "should raise 'Rate not found' if the conversion doesn't exist" do
      stub_error_response()
      
      converter = GoogleFinanceCurrencyConverter.new(:from => 'BRL', :to => 'ALL')
      lambda {
        converter.rate
      }.should raise_error("Rate not found")
    end
  end
end