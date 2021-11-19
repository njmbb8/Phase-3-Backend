class OrderContent < ActiveRecord::Base
    belongs_to :order
    has_many :items
end