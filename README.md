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
| birth_year         | date    | null: false               |
| birth_month        | date    | null: false               |
| birth_day          | date    | null: false               |

### association
- has_many :items
- has_many :purchase


## itemsテーブル
| Column           |Type        | Options                        |
| -----------------|------------| ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| item_category_id | integer    | null: false                    |
| item_status_id   | integer    | null: false                    |
| shipping_fee_id  | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_days_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### association
- belongs_to :user
- has_one :purchases
- belongs_to :category
- belongs_to :status
- belongs_to :fee
- belongs_to :prefecture
- belongs_to :days


## purchasesテーブル
| Column         |Type        |Options                         |
| ---------------|------------|--------------------------------|
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| address        | string     |                                |
| phone_number   | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |


### association
- belongs_to :user
- belongs_to :item
- belongs_to :prefecture