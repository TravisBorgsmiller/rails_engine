require 'rails_helper'

RSpec.describe 'Items' do
  describe 'Items API' do
    it 'sends a list of all items' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      create_list(:item, 5, merchant_id: merchant.id)
      create_list(:item, 10, merchant_id: merchant_2.id)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]

      expect(items.count).to eql(15)
      expect(items[0]['attributes']).to have_key('id')
      expect(items[0]['attributes']).to have_key('merchant_id')
      expect(items[0]['attributes']).to have_key('unit_price')
      expect(items[0]['attributes']).to have_key('description')
      expect(items[0]['attributes']).to have_key('name')
      expect(items[0]['relationships']).to have_key('merchant')
    end
    it "can get one item by its id" do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant_2.id)

      get "/api/v1/items/#{item_1.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item['attributes']['merchant_id']).to eql(merchant.id)
      expect(item['attributes']['merchant_id']).not_to eql(merchant_2.id)
      expect(item['attributes']).to have_key('unit_price')
      expect(item['attributes']).to have_key('description')
      expect(item['attributes']).to have_key('name')
      expect(item['relationships']).to have_key('merchant')
    end
    it "can create a new item" do
      merchant = create(:merchant)
      item_params = { name: "tom", description: "Where is tom", merchant_id: merchant.id, unit_price: 34324 }

      post "/api/v1/items", params: {item: item_params}
      item = Item.last

      expect(response).to be_successful
      expect(item.name).to eq('tom')
    end
    it "can update an existing item" do
      merchant = create(:merchant)
      item_params = { name: "tom", description: "where is tom", merchant_id: merchant.id, unit_price: 23432 }
      post "/api/v1/items", params: {item: item_params}
      id = Item.last.id
      previous_name = Item.last.name
      item_update_param = { name: "John" }

      put "/api/v1/items/#{id}", params: {item: item_update_param}
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("john")
    end
    it "can destroy an item" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id)

      expect{ delete "/api/v1/items/#{item_1.id}" }.to change(Item, :count).by(-1)

      expect(response).to be_successful
      expect{Item.find(item_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

end
