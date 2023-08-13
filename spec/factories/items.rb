FactoryBot.define do
  factory :item do
    name {'最新のポケモンカード'}
    description {Faker::Lorem.sentence}
    item_category_id {2}
    item_status_id {2}
    shipping_fee_id {2}
    prefecture_id {2}
    shipping_day_id {2}
    price {30000}
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end    
  end
end
