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
| birth_date         | date    | null: false               |

### association
- has_many :items
- has_many :purchases



## itemsテーブル
| Column           |Type        | Options                        |
| -----------------|------------| ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| item_category_id | integer    | null: false                    |
| item_status_id   | integer    | null: false                    |
| shipping_fee_id  | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_day_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### association
- belongs_to             :user
- has_one                :purchase
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :shipping_fee
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :shipping_days



## purchasesテーブル
| Column         |Type        |Options                         |
| ---------------|------------|--------------------------------|
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :item
- has_one    :buyer



## buyersテーブル
| Column         |Type        |Options                         |
| ---------------|------------|--------------------------------|
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| house_number   | string     | null: false                    | 
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| purchase       | references | null: false, foreign_key: true |

### association
- belongs_to             :purchase
- belongs_to_active_hash :prefecture