require 'open-uri'

class GoogleFinanceCurrencyConverter
  def initialize(params={})
    @from = params[:from]
    @to = params[:to]
    @amount = params[:amount]
    @amount = 1 if @amount == nil
    raise "Same code" if @from == @to
  end

  def result
    return 0 if @amount == 0
    parse_response(request)
  end

  private
    def request
      open("http://www.google.com/finance/converter?a=#{@amount}&from=#{@from}&to=#{@to}").read
    end

    def parse_response(response)
      scanned_result = response.scan(/<span class=bld>([^.]+(?:\.(?:\d+))?)/)
      raise "Result not found" if scanned_result.empty?
      scanned_result[0][0].to_f
    end
end