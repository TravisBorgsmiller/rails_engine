require 'rails_helper'

RSpec.describe 'items and merchants' do
  describe 'Relationship records' do
    it 'can find a list of items from a specific merchant' do
      merchant_id = create(:merchant).id
      merchant2_id = create(:merchant).id

      items = create_list(:item, 7, merchant_id: merchant_id)

      get "/api/v1/merchants/#{merchant_id}/items"

      items = JSON.parse(response.body)['data']

      expect(response).to be_successful

      expect(items.count).to eql(7)
      expect(items.last['attributes']['merchant_id']).to_not be eql(merchant2_id)
    end
    it 'can get associated merchant by item id' do
      merchant_1 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id)

      get "/api/v1/items/#{item_1.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)['data']

      expect(merchant['attributes']['id']).to eql(merchant_1.id)
    end

  end

end
