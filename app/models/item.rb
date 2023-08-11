class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_days

  #空の投稿を保存できないようにする
  validates :name, presence: true
  validates :description, presence: true

  #価格の投稿時、半角数字かつ￥333～￥9,999,999以外の時は保存できないようにする
  with_options presence: true, format: { with: /\A[a-z0-9]+\z/i } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is invalid" },
    presence: { message: "can't be blank"}
  end

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :item_category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_fee_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}
end
