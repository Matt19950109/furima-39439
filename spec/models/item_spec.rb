require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '内容に問題ない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@item).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '画像が添付されていない場合、出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がないと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品名が40字以上なら出品できない' do
        @item.name = Faker::Lorem.characters(number:41)
        @item.valid?
        expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
      it '商品説明がないと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品説明が1000字以上なら出品できない' do
        @item.description = Faker::Lorem.characters(number:1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
      end
      it 'カテゴリーを選択しないと出品できない' do
        @item.item_category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end
      it '商品の状態を選択しないと出品できない' do
        @item.item_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end
      it '配送料の負担を選択しないと出品できない' do
        @item.shipping_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it '発送元の都道府県を選択しないと出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '配送までの日数を選択しないと出品できない' do
        @item.shipping_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '価格を入力しないと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格を全角で入力すると出品できない' do
        @item.price = '５０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it '価格を￥300～￥9999999以内に収めないと出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of range")
      end
      it 'userが紐づいていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
