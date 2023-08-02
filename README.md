# テーブル設計

## usersテーブル 
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_year         | integer | null: false               |
| birth_month        | integer | null: false               |
| birth_day          | integer | null: false               |

### association
- has_many :items
- has_many :purchases


## itemsテーブル
| Column        |Type        | Options                        |
| --------------|------------| ------------------------------ |
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| item_category | integer    | null: false                    |
| status        | integer    | null: false                    |
| shipping_fee  | integer    | null: false                    |
| prefecture    | integer    | null: false                    |
| shipping_days | integer    | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### association
- belongs_to :user
- has_one :purchases


## purchasesテーブル
| Column      |Type        |Options                         |
| ------------|------------|--------------------------------|
| postal_code | string     | null: false                    |
| prefecture  | integer    | null: false                    |
| city        | string     | null: false                    |
| address     | string     |                                |
| phone_number| integer    | null: false                    |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |


### association
- belongs_to :user
- belongs_to :item