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
| birth_year         | integer | null: false               |
| birth_month        | integer | null: false               |
| birth_day          | integer | null: false               |

### Association

- has_many :items
- has_many :sale_records
- has_many :destinations

## items テーブル

| Column              | Type        | Option                         |
| ------------------- | ----------- | ------------------------------ |
| name                | string      | null: false                    |
| info                | text        | null: false                    |
| category            | string      | null: false                    |
| status              | string      | null: false                    |
| shipping_fee_status | string      | null: false                    |
| prefecture          | string      | null: false                    |
| scheduled_delivery  | string      | null: false                    |
| price               | integer     | null: false                    |
| commission          | integer     | null: false                    |
| profit              | integer     | null: false                    |
| user_id             | references  | null: false, foreign_key: true |

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
| prefecture     | string     | null: false                    |
| city           | string     | null: false                    |
| address        | string     | null: false                    |
| building       | string     | null: false                    |
| phone_number   | string     | null: false                    |
| user_id        | references | null: false, foreign_key: true |
| sale_record_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :sale_record