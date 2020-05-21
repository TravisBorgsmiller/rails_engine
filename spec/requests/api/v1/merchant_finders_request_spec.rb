require 'rails_helper'

RSpec.describe 'Finding records' do
  describe 'Merchant request' do
    it 'can find a merchant by their name' do
      merchant = create(:merchant, name: 'Steve')

      get "/api/v1/merchants/find?name=steve"

      merchant = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchant[0]['attributes']['name']).to eql('Steve')
    end
    it 'can find a merchant by their id' do
      merchant = create(:merchant, id: 214)

      get "/api/v1/merchants/find?id=#{merchant.id}"

      merchant = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchant[0]['attributes']['id']).to eql(214)
    end
    it 'can find a merchant by date created at' do
      merchant_1 = create(:merchant, created_at: "2003-02-31 01:32:02 UTC")
      merchant_2 = create(:merchant, created_at: "2002-01-23 02:31:03 UTC")

      get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

      merchant = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchant[0]['attributes']['id']).to eql(merchant_1.id)
    end
    it 'can find a merchant by date updated at' do
      merchant_1 = create(:merchant, updated_at: "2003-03-21 02:21:04 UTC")
      merchant_2 = create(:merchant, updated_at: "2003-02-13 02:35:02 UTC")

      get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

      merchant = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchant[0]['attributes']['id']).to eql(merchant_1.id)
    end
    it 'can find all merchants by name' do
      merchant_1 = create(:merchant, name: "Jason")
      merchant_2 = create(:merchant, name: "Jason")
      merchant_3 = create(:merchant, name: "Travis")

      expect(merchant_1.id).not_to eql(merchant_2.id)

      get "/api/v1/merchants/find_all?name=son"

      merchants = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchants.count).to eql(2)
      expect(merchants[0]['attributes']['id']).to eql(merchant_1.id)
      expect(merchants[1]['attributes']['id']).to eql(merchant_2.id)
    end
    it 'can find all merchants by id' do
      merchant_1 = create(:merchant, id: 2)
      merchant_2 = create(:merchant, id: 3)

      get "/api/v1/merchants/find_all?id=3"

      merchants = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchants.count).to eql(1)
      expect(merchants[0]['attributes']['id']).to eql(merchant_2.id)
    end
    it 'can find all merchants by date created at' do
      merchant_1 = create(:merchant, created_at: "2002-02-11 01:21:01 UTC")
      merchant_2 = create(:merchant, created_at: "2011-01-23 02:25:03 UTC")
      merchant_3 = create(:merchant, created_at: "2002-02-11 01:21:01 UTC")

      expect(merchant_1.id).not_to eql(merchant_3.id)

      get "/api/v1/merchants/find_all?created_at=2002-02-11 01:21:01 UTC"

      merchants = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchants.count).to eql(2)
      expect(merchants[0]['attributes']['id']).to eql(merchant_1.id)
      expect(merchants[1]['attributes']['id']).to eql(merchant_3.id)
    end
    it 'can find all merchants by updated at' do
      merchant_1 = create(:merchant, updated_at: "2011-01-31 01:32:04 UTC")
      merchant_2 = create(:merchant, updated_at: "2009-03-23 01:35:03 UTC")

      expect(merchant_1.id).not_to eql(merchant_2.id)

      get "/api/v1/merchants/find_all?updated_at=2011-01-31 01:32:04 UTC"

      merchants = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchants.count).to eql(1)
      expect(merchants[0]['attributes']['id']).to eql(merchant_1.id)
    end

  end

end
