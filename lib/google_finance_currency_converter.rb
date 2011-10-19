require 'open-uri'

class GoogleFinanceCurrencyConverter
  def initialize(params={})
    @from = params[:from]
    @to = params[:to]
  end

  def value
    parse_response(request)
  end

  private
    def request
      open("http://www.google.com/finance/converter?a=1&from=#{@from}&to=#{@to}").read
    end

    def parse_response(response)
      response.scan(/<span class=bld>([^.]+\.(?:\d{1,2}))/)[0][0].to_f
    end
end