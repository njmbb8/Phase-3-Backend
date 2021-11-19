class Item < ActiveRecord::Base
    belongs_to :order_contents
end