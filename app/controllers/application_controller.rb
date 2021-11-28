require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/items" do
    Item.all.to_json
  end

  post '/items/' do
    item = Item.create(
      name: params[:name],
      image: params[:image],
      price: params[:price]
    )

    item.to_json
  end
end
