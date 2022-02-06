require 'rails_helper'

RSpec.describe SaleRecordDestination, type: :model do
  describe '売却情報の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @sale_record_destination = FactoryBot.build(:sale_record_destination, user_id: user.id, item_id: item.id)
      sleep(0.1)
    end

    context '内容に問題が無い場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@sale_record_destination).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @sale_record_destination.building = ''
        expect(@sale_record_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @sale_record_destination.postal_code = ''
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @sale_record_destination.postal_code = '1234567'
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include(
          'Postal code is invalid. Enter it as follows (e.g. 123-4567)'
        )
      end
      it 'prefectureを選択していないと保存できないこと' do
        @sale_record_destination.prefecture_id = '1'
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @sale_record_destination.city = ''
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @sale_record_destination.address = ''
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @sale_record_destination.phone_number = ''
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下だと保存できないこと' do
        @sale_record_destination.phone_number = '090123456'
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_numberが12桁以上だと保存できないこと' do
        @sale_record_destination.phone_number = '090123456789'
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include('Phone number is too long')
      end
      it 'phone_numberに半角数字以外が含まれている場合は購入できない' do
        @sale_record_destination.phone_number = 'a090123456a'
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include('Phone number  is invalid. Input only number')
      end
      it 'itemが紐付いていないと保存できないこと' do
        @sale_record_destination.item_id = ''
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("Item can't be blank")
      end
      it 'userが紐付いていないと保存できないこと' do
        @sale_record_destination.user_id = ''
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'tokenが空では保存できないこと' do
        @sale_record_destination.token = nil
        @sale_record_destination.valid?
        expect(@sale_record_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
