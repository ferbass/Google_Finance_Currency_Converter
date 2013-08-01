require 'open-uri'

class GoogleFinanceCurrencyConverter
  def initialize(params={})
    @from = params[:from]
    @to = params[:to]
    raise "Same code" if @from == @to
  end

  def rate
    parse_response(request)
  end

  private
    def request
      open("http://www.google.com/finance/converter?a=1&from=#{@from}&to=#{@to}").read
    end

    def parse_response(response)
      rate = response.scan(/<span class=bld>([^.]+(?:\.(?:\d+))?)/)
      raise "Rate not found" if rate.empty?
      rate[0][0].to_f
    end
end