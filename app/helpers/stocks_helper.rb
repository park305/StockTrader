module StocksHelper
 require 'net/http'

  def calculate_profitloss(marketprice, cost)
  	difference = marketprice.to_f - cost
  	percentage = (difference/cost) * 100
    percentage = percentage.round(2)
    difference = difference.round(2).to_s
  	difference + " (" + percentage .to_s + "%)"
  end

  def stock_price(symbol)
	  #symbol = params[:symbol]
	  url = URI::parse "http://download.finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=s0n0b0a0t1p0o0x0"
	  req = Net::HTTP::get(url).gsub /"/, ''
	  elems = req.split(",")
	  elems[2]
	  #{}"hi"

	  #req.split(",")
	#  respond_to do |format|
	 #   format.json { render :json => req.split(",") and return}
	 # end
    
    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #size = options[:size]
    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    #image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

end