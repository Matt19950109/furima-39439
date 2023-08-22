require 'rails_helper'

RSpec.describe PurchaseBuyer, type: :model do
  describe '購入者情報登録' do
    before do
      user = FactoryBot.create(:user) 
      item = FactoryBot.create(:item)
      @purchase_buyer = FactoryBot.build(:purchase_buyer, user_id: user.id, item_id: item.id)
      sleep(0.1)
    end

    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@purchase_buyer).to be_valid
      end
      it '建物名が空欄でも購入できる' do
        @purchase_buyer.building_name = ''
        expect(@purchase_buyer).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空欄だと購入できない' do
        @purchase_buyer.postal_code = ''
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号はハイフン(-)無しだと購入できない' do
        @purchase_buyer.postal_code = '1234567'
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号は全角数字だと購入できない' do
        @purchase_buyer.postal_code = '１２３-４５６７'
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '都道府県が空欄だと購入できない' do
        @purchase_buyer.prefecture_id = '1'
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空欄だと購入できない' do
        @purchase_buyer.city = ''
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("City can't be blank")
      end
      it '電話番号が空欄だと購入できない' do
        @purchase_buyer.phone_number = ''
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁未満だと購入できない' do
      @purchase_buyer.phone_number = '123456789'
      @purchase_buyer.valid?
      expect(@purchase_buyer.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it '電話番号が12桁以上だと購入できない' do
        @purchase_buyer.phone_number = '000000000000'
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it '電話番号にハイフン(-)があると購入できない' do
        @purchase_buyer.phone_number = '123-456-7890'
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'user情報が紐づいていないと購入できない' do
        @purchase_buyer.user_id = nil
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("User can't be blank")
      end
      it 'item情報が紐づいていないと購入できない' do
        @purchase_buyer.item_id = nil
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Item can't be blank")
      end
      it 'クレジットカード情報(token)が空だと購入できない' do
        @purchase_buyer.token = ''
        @purchase_buyer.valid?
        expect(@purchase_buyer.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
