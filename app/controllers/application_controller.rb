require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/items" do
    Item.all.to_json
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
end
