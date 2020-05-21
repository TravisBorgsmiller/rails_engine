require 'rails_helper'

RSpec.describe 'Merchants' do
  describe 'Merchant API' do
    it 'sends a list of merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants.count).to eql(3)
    end
    it 'can get one merchant by its id' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)['data']

      expect(response).to be_successful
      expect(merchant['attributes']['id']).to eq(id)
    end
    it 'can create a new merchant' do
      merchant_params = { id: 1, name: 'Travis' }

      post "/api/v1/merchants", params: {merchant: merchant_params}
      merchant = Merchant.last
      expect(response).to be_successful
      expect(merchant.name).to eq('travis')
    end
    it 'can update existing merchant' do
      merchant = create(:merchant)
      id = Merchant.last.id
      previous_name = Merchant.last.name
      merchant_update_param = { name: "John" }

      put "/api/v1/merchants/#{id}", params: {merchant: merchant_update_param}

      merchant.reload
      expect(response).to be_successful
      expect(merchant.name).to_not eq(previous_name)
      expect(merchant.name).to eq("john")
    end
    it 'can destroy a merchant' do
      merchant = create(:merchant)

      expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

      expect(response).to be_successful
      expect{Item.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

end
