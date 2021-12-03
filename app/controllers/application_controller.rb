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
    User.all.to_json(:include => :orders)
  end

  patch '/users/:id' do
    user = User.find(params[:id])
    user.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      address: params[:address]
    )
    user.to_json(:include => :orders)
  end

  delete '/users/:id' do
    User.find(params[:id]).destroy
    200
  end

  post '/users' do
    user = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      address: params[:address]
    )
    user.to_json(:include => :orders)
  end

  get '/orders' do
    Order.all.to_json(:include => [:user, :order_contents])
  end

  patch '/orders/:id' do
    order = Order.find(params[:id])
    order.update(
      user_id: params[:user_id],
      fulfilled: params[:fulfilled]
    )
    order.to_json(:include => [:user, :order_contents])
  end

  delete '/orders/:id' do
    Order.find(params[:id]).destroy
    200
  end

  post '/orders' do
    order = Order.create(
      user_id: params[:user_id],
      fulfilled: false
    )
    order.to_json(:include => [:user, :order_contents])
  end

  post '/addcontents' do
    contents = OrderContent.create(
      order_id: params[:order_id],
      item_id: params[:item_id],
      quantity: params[:quantity]
    )
    contents.to_json
  end

  delete '/contents/:id' do
    OrderContent.find(params[:id]).destroy
    200
  end

  patch '/contents/:id' do
    content = OrderContent.find(params[:id])
    content.update(
      order_id: params[:order_id],
      item_id: params[:item_id],
      quantity: params[:quantity]
    )
    content.to_json
  end
end
