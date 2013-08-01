$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'webmock/rspec'

require 'google_finance_currency_converter'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

def stub_converted_val_response(val)
  File.open(File.expand_path(File.dirname(__FILE__) + '/helper/response.html'), 'r') do |f|
    stub_request(:get, "http://www.google.com/finance/converter?a=1&from=GBP&to=BRL").
        to_return(:body => f.read.gsub("<converted_val>", val.to_s))
  end
end

def stub_error_response
  File.open(File.expand_path(File.dirname(__FILE__) + '/helper/error.html'), 'r') do |f|
    stub_request(:get, "http://www.google.com/finance/converter?a=1&from=BRL&to=ALL").
        to_return(:body => f.read)
  end
end