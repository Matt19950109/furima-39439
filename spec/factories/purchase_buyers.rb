FactoryBot.define do
  factory :purchase_buyer do
    postal_code {'123-4567'}
    prefecture_id {'2'}
    city {'神奈川県'}
    house_number {'1-1'}
    building_name {'神奈川ハイツ'}
    phone_number {'0123456789'}
    token {'tok_abcdefghijk00000000000000000'}
    association :user
    association :item
  end
end
