FactoryBot.define do
  factory :user do
    nickname {'furiMa太郎'}
    email {'sample@gmail.com'}
    password {'sample01'}
    password_comfirmation { password }
    last_name {'田中'}
    first_name {'太郎'}
    last_name_kana {'タナカ'}
    first_name_kana {'タロウ'}
    birth_date{'1995-01-09'}
    
  end
end
