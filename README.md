# テーブル設計

## users テーブル

| Column             | Type    | Option                    |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               | 
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthday           | date    | null: false               |

### Association

- has_many :items
- has_many :sale_records

## items テーブル

| Column                 | Type        | Option                         |
| ---------------------- | ----------- | ------------------------------ |
| name                   | string      | null: false                    |
| info                   | text        | null: false                    |
| category_id            | integer     | null: false                    |
| status_id              | integer     | null: false                    |
| shipping_fee_status_id | integer     | null: false                    |
| prefecture_id          | integer     | null: false                    |
| scheduled_delivery_id  | integer     | null: false                    |
| price                  | integer     | null: false                    |
| user                   | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :sale_record

## sale_records

| Column              | Type        | Option                         |
| ------------------- | ----------- | ------------------------------ |
| name                | string      | null: false                    |
| price               | integer     | null: false                    |
| shipping_fee_status | string      | null: false                    |
| user_id             | references  | null: false, foreign_key: true |
| item_id             | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :destination

## destinations

| Column         | Type       | Option                         |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| address        | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| sale_record    | references | null: false, foreign_key: true |

### Association

- belongs_to :sale_record