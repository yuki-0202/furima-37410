class SaleRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index]

  def index
    @sale_record = SaleRecord.new
    @sale_record_destination = SaleRecordDestination.new
  end

  def create
    @sale_record_destination = SaleRecordDestination.new(sale_record_params)
    @sale_record_destination.token = params[:token]
    if @sale_record_destination.valid?
      pay_item
      @sale_record_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def sale_record_params
    params.require(:sale_record_destination).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id].to_i)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if SaleRecord.exists?(item_id: params[:item_id]) || @item.user_id == current_user.id
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: @sale_record_destination.token,
        currency: 'jpy'
      )
  end
end
