class ItemsController < ApplicationController
  before_action :set_item, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:index, :show]
  before_action :contributor_confirmation, only:[:edit, :update, :destroy]

  def index
    @item = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :item_category_id, :item_status_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    unless current_user.id == @item.user_id
      redirect_to root_path 
    end
  end
end
