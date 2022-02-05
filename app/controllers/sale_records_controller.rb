class SaleRecordsController < ApplicationController
  def index
    @sale_record = SaleRecord.new
    @item = Item.find(params[:item_id])
    @sale_record_destination = SaleRecordDestination.new
  end

  def create
    @sale_record_destination = SaleRecordDestination.new(sale_record_params)
    if @sale_record_destination.valid?
      @sale_record_destination.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def sale_record_params
    params.require(:sale_record_destination).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id].to_i)
  end
end
