require 'faker'

50.times do 
    User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        address: Faker::Address.full_address
    )
end

Item.create( name: "banana", price: 10, image: "banana.jpg")
Item.create(name: "airplane", price: 10000000.50, image: "airplane.jpg")
Item.create(name: "puppy", price: 1234.56, image: "puppy.jpg")
Item.create(name: "soda", price: 5, image: "soda.jpg")
Item.create(name: "tape", price: 1, image: "tape.jpg")
Item.create(name: "shoes", price: 25, image: "shoes.jpg")
Item.create(name: "sushi", price: 234.93, image: "sushi.jpg")
Item.create(name: "humidifier", price: 11, image: "humidifier.jpg")

100.times do
    order = Order.create(
        user_id: rand(1..User.all.size),
        fulfilled: rand(2)
    )

    rand(11).times do
        Order_content.create(
            order_id: order.id,
            item_id: rand(Item.all.size),
            quantity: rand(30)
        )
    end
end