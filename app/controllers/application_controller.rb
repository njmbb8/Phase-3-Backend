require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/items" do
    Item.all.to_json
  end

  get "/items/:id" do
    Item.find(params[:id]).to_json
  end

  post '/items' do
    item = Item.create(
      name: params[:name],
      image: params[:image],
      price: params[:price]
    )

    item.to_json
  end

  post '/upload' do
    if params[:image] && params[:image][:filename]
      filename = params[:image][:filename]
      file = params[:image][:tempfile]
      path = File.join(settings.public_folder, params[:image][:filename])

      File.open(path, 'wb') do |f|
        f.write(file.read)
      end
      200
    end
  end

  get '/images/:image' do
    send_file File.join(settings.public_folder, params[:image])
  end

  delete '/items/:id' do
    item = Item.find(params[:id])
    item.destroy
    File.delete(File.join(settings.public_folder, item[:image]))
    200
  end

  patch '/items/:id' do
    item = Item.find(params[:id])
    item.update(
      name: params[:name],
      price: params[:price],
      image: params[:image]
    )
    item.to_json
  end

  get '/users' do
    User.all.to_json
  end

  get '/users/:id/orders' do
    User.find(params[:id]).orders.to_json
  end

  patch '/users/:id' do
    user = User.find(params[:id])
    user.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      address: params[:address]
    )
    user.to_json
  end

  delete '/users/:id' do
    User.find(params[:id]).destroy
    200
  end
end
