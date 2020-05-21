require 'rails_helper'

RSpec.describe 'Finding records' do
  describe 'Item request' do
    it 'can find an item by its id' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, id: 222)
      item_2 = create(:item, merchant_id: merchant_2.id, id: 111)

      get "/api/v1/items/find?id=#{item_1.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']['merchant_id']).to eql(item_1.merchant_id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can find an item by its merchant id' do
      merchant = create(:merchant, id: 222)
      merchant_2 = create(:merchant, id: 6)

      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant_2.id)

      get "/api/v1/items/find?merchant_id=#{item_1.merchant_id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item[0]['attributes']['merchant_id']).to eql(merchant.id)
      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can find an item by its name' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, name: "Broken Phone")
      item_2 = create(:item, merchant_id: merchant_2.id, name: "Thick Towels")

      get "/api/v1/items/find?name=#{item_1.name}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item[0]['attributes']['name']).to eql('Broken phone')
      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can find an item by its description' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, description: "Delicious shrimp on the barbie")
      item_2 = create(:item, merchant_id: merchant_2.id, description: "Yummy")

      get "/api/v1/items/find?description=#{item_1.description}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can get an item by its date created' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, created_at: "2005-03-31 02:31:06 UTC")
      item_2 = create(:item, merchant_id: merchant_2.id, created_at: "2004-02-22 02:31:04 UTC")

      get "/api/v1/items/find?created_at=#{item_1.created_at}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can get an item by its date updated' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, updated_at: "2003-02-12 02:33:03 UTC")
      item_2 = create(:item, merchant_id: merchant_2.id, updated_at: "2008-03-23 02:31:04 UTC")

      get "/api/v1/items/find?updated_at=#{item_1.updated_at}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']
      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can get an item by its unit price' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, unit_price: 6546)
      item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 2534)

      get "/api/v1/items/find?unit_price=#{item_1.unit_price}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item[0]['attributes']['unit_price']).to eql('65.46')
      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can find all items by an id' do
      merchant = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, id: 33)
      item_2 = create(:item, merchant_id: merchant.id, id: 23)

      get "/api/v1/items/find_all?id=#{item_1.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item.count).to eql(1)
      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can find all items by a merchant id' do
      merchant = create(:merchant)
      merchant2 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)
      item_4 = create(:item, merchant_id: merchant2.id)

      get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

      expect(response).to be_successful

      items = JSON.parse(response.body)['data']

      expect(items.count).to eql(3)
      expect(items[0]['attributes']['id']).to eql(item_1.id)
      expect(items[0]['attributes']).to have_key('unit_price')
      expect(items[0]['attributes']).to have_key('description')
      expect(items[0]['attributes']).to have_key('name')
      expect(items[0]['relationships']).to have_key('merchant')
      expect(items[1]['attributes']['id']).to eql(item_2.id)
      expect(items[1]['attributes']).to have_key('unit_price')
      expect(items[1]['attributes']).to have_key('description')
      expect(items[1]['attributes']).to have_key('name')
      expect(items[1]['relationships']).to have_key('merchant')
      expect(items[2]['attributes']['id']).to eql(item_3.id)
    end
    it 'can find all item by a name' do
      merchant = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, name: "Larry")
      item_2 = create(:item, merchant_id: merchant.id, name: "Ellison")

      get "/api/v1/items/find_all?name=#{item_1.name}"

      expect(response).to be_successful

      item = JSON.parse(response.body)['data']

      expect(item.count).to eql(1)

      expect(item[0]['attributes']['name']).to eql('Larry')
      expect(item[0]['attributes']['id']).to eql(item_1.id)
      expect(item[0]['attributes']).to have_key('unit_price')
      expect(item[0]['attributes']).to have_key('description')
      expect(item[0]['attributes']).to have_key('name')
      expect(item[0]['relationships']).to have_key('merchant')
    end
    it 'can find all item by a description' do
      merchant = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, description: "Crystal clear")
      item_2 = create(:item, merchant_id: merchant.id, description: "Wood stain finish")
      item_3 = create(:item, merchant_id: merchant.id, description: "Crystal clear")

      get "/api/v1/items/find_all?description=#{item_1.description}"

      expect(response).to be_successful

      items = JSON.parse(response.body)['data']

      expect(items.count).to eql(2)
      expect(items[0]['attributes']['id']).to eql(item_1.id)
      expect(items[0]['attributes']).to have_key('unit_price')
      expect(items[0]['attributes']).to have_key('description')
      expect(items[0]['attributes']).to have_key('name')
      expect(items[0]['relationships']).to have_key('merchant')
      expect(items[1]['attributes']['id']).to eql(item_3.id)
      expect(items[1]['attributes']).to have_key('unit_price')
      expect(items[1]['attributes']).to have_key('description')
      expect(items[1]['attributes']).to have_key('name')
      expect(items[1]['relationships']).to have_key('merchant')
    end
    it 'can get all item by a date created' do
      merchant = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, created_at: "2022-02-12 02:31:02 UTC")
      item_2 = create(:item, merchant_id: merchant.id, created_at: "2011-03-23 02:35:01 UTC")
      item_3 = create(:item, merchant_id: merchant.id, created_at: "2022-02-12 02:31:02 UTC")

      get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

      expect(response).to be_successful

      items = JSON.parse(response.body)['data']

      expect(items.count).to eql(2)
      expect(items[0]['attributes']['id']).to eql(item_1.id)
      expect(items[0]['attributes']).to have_key('unit_price')
      expect(items[0]['attributes']).to have_key('description')
      expect(items[0]['attributes']).to have_key('name')
      expect(items[0]['relationships']).to have_key('merchant')
      expect(items[1]['attributes']['id']).to eql(item_3.id)
    end
    it 'can get all item by a date updated' do
      merchant = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, updated_at: "2003-01-31 01:22:04 UTC")
      item_2 = create(:item, merchant_id: merchant.id, updated_at: "2002-01-31 02:22:04 UTC")
      item_3 = create(:item, merchant_id: merchant.id, updated_at: "2003-01-31 01:22:04 UTC")

      get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"

      expect(response).to be_successful

      items = JSON.parse(response.body)['data']

      expect(items.count).to eql(2)
      expect(items[0]['attributes']['id']).to eql(item_1.id)
      expect(items[0]['attributes']).to have_key('unit_price')
      expect(items[0]['attributes']).to have_key('description')
      expect(items[0]['attributes']).to have_key('name')
      expect(items[0]['relationships']).to have_key('merchant')
      expect(items[1]['attributes']['id']).to eql(item_3.id)
    end
    it 'can get an item by its unit price' do
      merchant = create(:merchant)

      item_1 = create(:item, merchant_id: merchant.id, unit_price: 2132)
      item_2 = create(:item, merchant_id: merchant.id, unit_price: 1233)
      item_3 = create(:item, merchant_id: merchant.id, unit_price: 2132)

      get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"

      expect(response).to be_successful

      items = JSON.parse(response.body)['data']

      expect(items.count).to eql(2)
      expect(items[0]['attributes']['id']).to eql(item_1.id)
      expect(items[1]['attributes']['id']).to eql(item_3.id)
      expect(items[1]['attributes']).to have_key('unit_price')
      expect(items[1]['attributes']).to have_key('description')
      expect(items[1]['attributes']).to have_key('name')
      expect(items[1]['relationships']).to have_key('merchant')
    end

  end

end
