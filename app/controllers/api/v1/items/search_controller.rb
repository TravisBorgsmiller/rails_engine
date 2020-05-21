class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.where(downcase_if_string))
  end

  def show
    render json: ItemSerializer.new(Item.where(downcase_if_string))
  end

  private

  def downcase_if_string
    if params[:name]
      name = params[:name].downcase
      "name like '%#{name}%'"
    elsif params[:description]
      description = params[:description].downcase
      "description like '%#{description}%'"
    else
      request.query_parameters
    end
  end

end
