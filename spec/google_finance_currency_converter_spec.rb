require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GoogleFinanceCurrencyConverter do
  describe "conversion" do
    it "should work with currency that returns an integer" do
      stub_converted_val_response(2, 1)

      converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL', :amount => 1)
      converter.rate.should == 2
    end

    it "should work with currency that returns a float" do
      stub_converted_val_response(4.784, 2)

      converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL', :amount => 2)
      converter.rate.should == 4.784
    end

    it "should set amount to 1 when amount is 0" do
        stub_converted_val_response(2.784, 1)
        converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL', :amount => 0)
        converter.rate.should == 2.784
    end

    it "should set amount to 1 when amount is nil" do
        stub_converted_val_response(2.784, 1)
        converter = GoogleFinanceCurrencyConverter.new(:from => 'GBP', :to => 'BRL', :amount => nil)
        converter.rate.should == 2.784
    end

  end

  describe "raising error" do
    it "should raise 'Same code' if from and to codes are the same" do
      lambda {
        converter = GoogleFinanceCurrencyConverter.new(:from => 'BRL', :to => 'BRL', :amount => 1)
      }.should raise_error("Same code")
    end

    it "should raise 'Rate not found' if the conversion doesn't exist" do
      stub_error_response()

      converter = GoogleFinanceCurrencyConverter.new(:from => 'BRL', :to => 'ALL', :amount => 1)
      lambda {
        converter.rate
      }.should raise_error("Rate not found")
    end
  end
end
