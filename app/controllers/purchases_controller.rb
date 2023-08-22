class PurchasesController < ApplicationController
  def index
    set_item
    @purchase_buyer = PurchaseBuyer.new
  end

  def new
  end

  def create
    set_item
    @purchase_buyer = PurchaseBuyer.new(purchase_params)
    if @purchase_buyer.valid?
      @purchase_buyer.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
   def purchase_params
    params.require(:purchase_buyer).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
   end

  def set_item
    @item = Item.find(params[:item_id])
  end

   end
end
