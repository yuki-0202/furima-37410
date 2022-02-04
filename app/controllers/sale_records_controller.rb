class SaleRecordsController < ApplicationController
  def index
    @sale_record = SaleRecord.new
    @item = Item.find(params[:item_id])
  end
end
