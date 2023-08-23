class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_has_been_purchased

  def index
    set_item
    set_gon
    @purchase_buyer = PurchaseBuyer.new
  end

  def new
  end

  def create
    set_item
    @purchase_buyer = PurchaseBuyer.new(purchase_params)
    if @purchase_buyer.valid?
      pay_item
      @purchase_buyer.save
      redirect_to root_path
    else
      set_gon
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

   def set_gon
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
   end

   def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
   end

   def item_has_been_purchased
    # 出品者もしくは購入済の商品の場合、購入画面に遷移しようとしてもトップページに戻る
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.purchase.present?
      redirect_to root_path
    end
   end
end
