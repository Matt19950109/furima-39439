class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_buyer = PurchaseBuyer.new
  end

  def new
  end

  def create
    @purchase_buyer = PurchaseBuyer.new(purchase_params)
    if @purchase_buyer.valid?
      @purchase_buyer.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private
   def purchase_params
    params.require(:purchase_buyer).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
   end
   end
end
