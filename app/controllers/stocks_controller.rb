class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
    @totalrevenue = Trade.where(:action => "SELL").sum('shares*price')
    @totalcost = Trade.where(:action => "BUY").sum('shares*price')
    @overall = @totalrevenue - @totalcost

  end

  def dispatchtest 
    render :inline => 'holyshit'
  end

  def deleter
    respond_to do |format|
      format.html 
      format.js   
    end
  end
  def deleteer
    @action = params[:selected]
    if @action == "sell"
      @stocksDropDown = ""
      @sellStocks = Stock.where("shares>0")
      @sellStocks.each do |stock| 
        symbol = stock.symbol.to_s
        @stocksDropDown = @stocksDropDown + '<option value="' + symbol + '">' + symbol + '</option>'
      end      
      @stocksDropDown = '<select>' + @stocksDropDown + '</select>'
    else 
      @stocksDropDown = ""
    end


    respond_to do |format|
      format.html 
      format.js   
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @trades = @stock.trades
    @totalrevenue = @stock.trades.where(:action => "SELL").sum('shares*price')
    @totalcost = @stock.trades.where(:action => "BUY").sum('shares*price')
    @overall = @totalrevenue - @totalcost
    
    #Trade.where(:action => "BUY", :stock_id => 11).sum(shares*price)
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end


  def ajaxtestpage    
  end

  # GET /stocks/new
  def newtest
    @sellStocks = Trade.where("action=?", "SELL")
    @stock = Stock.new
  end

  def ajaxtest
    action = params[:selected]
    if action == "sell"
      @stocksDropDown = ""
      @sellStocks = Stock.where("shares>0")
      @sellStocks.each do |stock| 
        symbol = stock.symbol.to_s
        @stocksDropDown = @stocksDropDown + '<option value="' + symbol + '">' + symbol + '</option>'
      end      
      @stocksDropDown = '<select>' + @stocksDropDown + '</select>'
      render :text => @stocksDropDown
    else 
      render :text => "nothing"
    end
  end


  def ajaxNumShares
    @symbol = params[:symbol]
    @myStock = Stock.where("symbol=" + @symbol)
    render :text => @myStock.shares
  end


  def ajaxtest2
    @action = params[:selected]
    if @action == "sell"
      @stocksDropDown = ""
      @sellStocks = Stock.where("shares>0")
      @sellStocks.each do |stock| 
        symbol = stock.symbol.to_s
        @stocksDropDown = @stocksDropDown + '<option value="' + symbol + '">' + symbol + '</option>'
      end      
      @stocksDropDown = '<select>' + @stocksDropDown + '</select>'
    else 
      @stocksDropDown = ""
    end



    respond_to do |format|
      format.html 
      format.js   
    end
  end


  def uplaodCSV
  end

  def upload
    require 'csv'
    uploaded_io = params[:picture]
    uploaded_filepath = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    #File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    File.open(uploaded_filepath, 'wb') do |file|    
      file.write(uploaded_io.read)
    end



    @people = []
    #CSV.foreach(File.path(Rails.root.join('public', 'uploads', uploaded_io.original_filename))) do |col|
    #CSV.foreach(File.path('stocks.csv')) do |col|    
    CSV.foreach(File.path(uploaded_filepath)) do |col|    

      #@people =  @people + col[0].to_s + "<br>"
      #@people << col[0].to_s + " " + col[1].to_s
      old_stock = Stock.find_by symbol: col[2]
      if old_stock
        new_trade = old_stock.trades.new(action: col[1], status: "ACTIVE", price: col[4], shares: col[3], date_posted: DateTime.strptime(col[0], '%m/%d/%y'))
        new_trade.save

        #new_trade = old_stock.trades.new
        #new_trade.action = col[1]
        #(action: col[1].to_s, status: "ACTIVE".to_s, price: 111, shares: col[3].to_s)

        #@people = @people = old_stock.symbol
      else
        new_stock = Stock.new(symbol: col[2])
        new_stock.save
        #new_stock.trades.new()
        new_trade = new_stock.trades.new(action: col[1], status: "ACTIVE", price: col[4], shares: col[3], date_posted: DateTime.strptime(col[0], '%m/%d/%y'))
        new_trade.save
      end

      #find Stock ID by using symbol
      #if it doesn't exist then insert new Stock row 
      #else use stock ID 
      #create new trade off of stock == @stock.TRade.create()
    end

  end

  # POST /stocks
  # POST /stocks.json
  def create
    params[:stock][:cost] = params[:trade][:price]
    params[:stock][:shares] = params[:trade][:shares]

    @stock = Stock.new(stock_params)
    #@trade = @stock.trades.build(trade_params)
    @trade = @stock.trades.new(trade_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stock }
      else
        format.html { render action: 'new' }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      #params.require(:stock).permit(:symbol, :cost, :shares)
      params.require(:stock).permit(:symbol, :cost, :shares)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_params
      params.require(:trade).permit(:action, :status, :price, :shares, :date_posted, :stock_id)
    end
end
