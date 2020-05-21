class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.where(downcase_if_string))
  end

  def show
    render json: MerchantSerializer.new(Merchant.where(downcase_if_string))
  end

  def downcase_if_string
    if params[:name]
      name = params[:name].downcase
      "name like '%#{name}%'"
    else
      request.query_parameters
    end
  end

end
